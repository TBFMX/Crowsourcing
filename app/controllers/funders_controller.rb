class FundersController < ApplicationController
  before_action :set_funder, only: [:show, :edit, :update, :destroy]
  #before_action :autorizado,  only: [ :edit, :update, :destroy]
  include Porta
  # GET /funders
  # GET /funders.json
  def index
    if params[:id].nil?
      redirect_to root_path
    end 
    @funders = Funder.where("project_id" => params[:id])
    @project = Project.find(params[:id])  
    add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s
    add_breadcrumb I18n.t("breadcrumbs.funders"), '/projects/funders/' + @project.id.to_s 
  end

  # GET /funders/1
  # GET /funders/1.json
  def show
    @user = User.find(@funder.user_id)
    @perk = Perk.find(@funder.perk_id)
  end

  # GET /funders/new/proyecto_id
  def new 
    @funder = Funder.new
  end
=begin
  # GET /funders/1/edit/proyecto_id
  def edit
        @project = params[:proy]
  end

  # POST /funders
  # POST /funders.json
  def create   
    @funder = Funder.new(funder_params)

    respond_to do |format|
      if @funder.save
        format.html { redirect_to @funder, notice: 'Funder was successfully created.' }
        format.json { render :show, status: :created, location: @funder }
      else
        format.html { render :new }
        format.json { render json: @funder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funders/1
  # PATCH/PUT /funders/1.json
  def update
    respond_to do |format|
      if @funder.update(funder_params)
        format.html { redirect_to @funder, notice: 'Funder was successfully updated.' }
        format.json { render :show, status: :ok, location: @funder }
      else
        format.html { render :edit }
        format.json { render json: @funder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funders/1
  # DELETE /funders/1.json
  def destroy
    @funder.destroy
    respond_to do |format|
      format.html { redirect_to funders_url, notice: 'Funder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funder
      @funder = Funder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funder_params
      params.require(:funder).permit(:user_id, :perk_id)
    end
=end    
end
