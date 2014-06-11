class AmendsController < ApplicationController
  before_action :set_amend, only: [:show, :edit, :update, :destroy]

  # GET /amends
  # GET /amends.json
  def index
    @amends = Amend.all
  end

  # GET /amends/1
  # GET /amends/1.json
  def show
  end

  # GET /amends/new
  def new
    @amend = Amend.new
    @project = params[:project]
    @user = session[:user_id]
  end

  # GET /amends/1/edit
  def edit
  end

  # POST /amends
  # POST /amends.json
  def create
    @project = params[:amends][:project]
    @user = params[:amends][:user]
    @pic = params[:amends][:image]
    @gallery = Gallery.where("project_id = ?",@project)
    
    #unless params[:image].nil?
      @pics = DataFile.save(@pic)
    #end
    @image = Image.new("galery_id" => @galleries.id, "image_url" => @pics)
    
    respond_to do |format|
      if @image.save
        format.html { 
          @amend = Amend.new("user_id"=>@user, "project_id" => @project, "description" => params[:amend][:description], "image_url" => @image)
          respond_to do |format|
            if @amend.save
              format.html { redirect_to @amend, notice: 'Amend was successfully created.' }
              format.json { render :show, status: :created, location: @amend }
            else
              format.html { render :new }
              format.json { render json: @amend.errors, status: :unprocessable_entity }
            end
          end
        }
  end

  # PATCH/PUT /amends/1
  # PATCH/PUT /amends/1.json
  def update
    respond_to do |format|
      if @amend.update(amend_params)
        format.html { redirect_to @amend, notice: 'Amend was successfully updated.' }
        format.json { render :show, status: :ok, location: @amend }
      else
        format.html { render :edit }
        format.json { render json: @amend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amends/1
  # DELETE /amends/1.json
  def destroy
    @amend.destroy
    respond_to do |format|
      format.html { redirect_to amends_url, notice: 'Amend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amend
      @amend = Amend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amend_params
      params.require(:amend).permit(:user_id, :description, :project_id, :image_id)
    end
end
