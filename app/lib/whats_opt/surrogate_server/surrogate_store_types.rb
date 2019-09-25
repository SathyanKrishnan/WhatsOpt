#
# Autogenerated by Thrift Compiler (0.11.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'

module WhatsOpt
  module SurrogateServer
    module SurrogateKind
      KRIGING = 0
      KPLS = 1
      KPLSK = 2
      LS = 3
      QP = 4
      VALUE_MAP = {0 => "KRIGING", 1 => "KPLS", 2 => "KPLSK", 3 => "LS", 4 => "QP"}
      VALID_VALUES = Set.new([KRIGING, KPLS, KPLSK, LS, QP]).freeze
    end

    class SurrogateException < ::Thrift::Exception
      include ::Thrift::Struct, ::Thrift::Struct_Union
      def initialize(message=nil)
        super()
        self.msg = message
      end

      def message; msg end

      MSG = 1

      FIELDS = {
        MSG => {:type => ::Thrift::Types::STRING, :name => 'msg'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class SurrogateQualification
      include ::Thrift::Struct, ::Thrift::Struct_Union
      R2 = 1
      YP = 2

      FIELDS = {
        R2 => {:type => ::Thrift::Types::DOUBLE, :name => 'r2'},
        YP => {:type => ::Thrift::Types::LIST, :name => 'yp', :element => {:type => ::Thrift::Types::DOUBLE}}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

  end
end