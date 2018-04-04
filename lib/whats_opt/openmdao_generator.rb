require 'erubi'
require 'tmpdir'
require 'zip'
require 'open3'

module WhatsOpt
  
  class OpenmdaoGenerator
    
    PYTHON = APP_CONFIG['python_cmd'] || "python"
    
    attr_accessor :genfiles 
    
    class DisciplineNotFoundException < StandardError
    end
    
    def initialize(mda)
      @mda = mda
      @template_dir = File.join(File.dirname(__FILE__), "templates")
      @genfiles = []
    end
        
    def generate(only_base=false)
      zip_filename = nil
      stringio = nil
      @genfiles = []
      Dir.mktmpdir("openmdao_#{@mda.name.downcase.tr(" ", "_")}_") do |dir|
        zip_filename = File.basename(dir)+".zip"
        _generate_mda dir, only_base
        stringio = Zip::OutputStream.write_buffer do |zio|
          @genfiles.each do |filename|
            zio.put_next_entry(File.join(File.basename(dir), File.basename(filename)))
            File.open(filename) do |f|
              zio.write f.read
            end
          end
        end
      end
      stringio.rewind
      return stringio.read, zip_filename
    end
            
    def check_mda_setup
      ok, lines = false, []
      Dir.mktmpdir("check_#{@mda.name.downcase.tr(" ", "_")}_") do |dir|
        _generate_mda dir
        ok, log = _check_mda dir   
        lines = log.lines.map(&:chomp)     
      end
      return ok, lines
    end
    
    def _generate_mda(gendir, only_base=false)
      @mda.disciplines.nodes.each do |disc|
        _generate_discipline(disc, gendir, only_base)
      end 
      _generate_main(gendir, only_base)
      _generate_screening(gendir)
    end
        
    def _check_mda(gendir)
      script = File.join(gendir, @mda.py_filename) 
      stdouterr, status = Open3.capture2e(PYTHON, script, '--no-n2')
      return status.success?, stdouterr
    end

    def _generate_discipline(discipline, gendir, only_base=false)
      @discipline=discipline  # @discipline used in template
      _generate(discipline.py_filename, 'openmdao_discipline.py.erb', gendir) unless only_base
      _generate(discipline.py_basefilename, 'openmdao_discipline_base.py.erb', gendir)
    end
    
    def _generate_main(gendir, only_base=false)
      _generate(@mda.py_filename, 'openmdao_main.py.erb', gendir) unless only_base
      _generate(@mda.py_basefilename, 'openmdao_main_base.py.erb', gendir)
    end    
       
    def _generate_screening(gendir)
      _generate('run_screening.py', 'run_screening.py.erb', gendir)
    end
     
    def _generate(filename, template_filename, gendir)
      template = File.join(@template_dir, template_filename)
      Rails.logger.info "Creating #{filename} from #{File.basename(template)}"
      filepath = File.join(gendir, filename) if gendir      
      result = _comment_header(filepath)
      result += _run_template(template)
      fh = File.open(filepath, "w:utf-8") 
      fh.print result
      fh.close
      @genfiles << filepath if !@genfiles.include?(filepath)
      filepath
    end
        
    def _run_template(name)
      erb = ERB.new(File.open(name, "rb:utf-8").read, nil, '-')
      erb.result(binding)
    end
    
    def _comment_header(filepath)
<<HEADER
# -*- coding: utf-8 -*-
"""
  #{File.basename(filepath)} generated by WhatsOpt. 
"""
HEADER
    end
    
  end
  
end
