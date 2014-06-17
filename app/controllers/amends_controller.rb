class AmendsController < ApplicationController
  before_action :set_amend, only: [:show, :edit, :update, :destroy]
  #before_action :autorizado,  only: [ :edit, :update, :destroy]
  #add_breadcrumb I18n.t("breadcrumbs.amends"), amends_path()
  include Porta

  # GET projects/amends/:id
  # GET /amends.json
  def index
    if params[:id].nil?
      redirect_to root_path
    end
      
    @amends = Amend.where("project_id" => params[:id])
    @project = Project.find(params[:id])
    add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s
    add_breadcrumb I18n.t("breadcrumbs.amends"), '/projects/amends/' + @project.id.to_s 
  end

  # GET /amends/1
  # GET /amends/1.json
  def show
      add_breadcrumb I18n.t("breadcrumbs.amends"), amends_path(@amend)
      check_propiety(@amend.project_id)
  end

  # GET /amends/new/proyecto_id
  def new
    
    #@project = params[:proy]
    @project2 = params[:id]
    @project = Project.find(@project2)
    @user = session[:user_id]
    @amend = Amend.new("project_id" => @project2)
    add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s
    add_breadcrumb I18n.t("breadcrumbs.amends"), '/projects/amends/' + @project.id.to_s 
  end

  # GET /amends/1/edit/proyecto_id
  def edit

    @project = params[:proy]
    @project2 = Project.find(@project)
    add_breadcrumb @project.name.to_s, '/projects/' + @project2.id.to_s
    add_breadcrumb I18n.t("breadcrumbs.amends"), '/projects/amends/' + @project2.id.to_s 
  end

  # POST /amends
  # POST /amends.json
  def create
    @project = params[:amend][:project_id]
    @user = params[:amend][:user]
    @pic = params[:amend][:image]

    #hasta aqui bien  

    @gallery = Gallery.where("project_id = ?",@project).limit(1).map { |l| l.id }
     puts"------------------------------------------------------"
     puts @gallery.inspect
     puts"------------------------------------------------------"
    


    unless params[:image].nil?
      @pics = DataFile.save(@pic)
    else
      @pics = ""  
    end
    #no agarra el id de galery
    @image = Image.new("galery_id" => @gallery, "image_url" => @pics)
    
    respond_to do |format|
      if @image.save
        format.html { 

          @amend = Amend.new("user_id"=>@user, "project_id" => @project, "description" => params[:amend][:description], "image_id" => @image.id)
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
        format.json { render :show, status: :created, location: @amend }    
      end
    end  
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
