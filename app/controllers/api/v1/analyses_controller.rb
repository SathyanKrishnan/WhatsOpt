class Api::V1::AnalysesController < Api::ApiController 

  before_action :set_mda, only: [:show, :update]
  
  # GET /api/v1/mdas
  def index
    @mdas = policy_scope(Analysis)
    json_response @mdas
  end    
      
  # GET /api/v1/mda/1
  def show
    if params[:format] == 'xdsm'
      render json: @mda.to_mda_viewer_json
    else
      json_response @mda
    end
  end
  
  # POST /api/v1/mdas
  def create
    @mda = Analysis.new(mda_params)
    authorize @mda
    @mda.save!
    set_ownership!(@mda)
    json_response @mda, :created
  end

  # PUT/PATCH /api/v1/mdas/1
  def update
    @mda.update!(mda_params)
    head :no_content
  end
  
  private

    def set_ownership!(mda)
      current_user.add_role(:owner, mda)
      @mda.descendants.each {|mda| current_user.add_role(:owner, mda)}
      current_user.save!
    end

    def set_mda
      @mda = Analysis.find(params[:id])
      authorize @mda
    end
  
    def mda_params
      params.require(:analysis).permit(
        :name, 
        :public,
        :disciplines_attributes => 
          [
            :name, 
            :variables_attributes => [:name, :io_mode, :type, :shape, :units, :desc, 
                                      :parameter_attributes => [:lower, :upper, :init]
                                    ],
            :sub_analysis_attributes => {}
          ]
      )
    end
  
end