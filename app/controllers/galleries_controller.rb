class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  #before_action :autorizado,  only: [ :edit, :update, :destroy]
    include Porta

  # GET /galleries
  # GET /galleries.json
  def index
    if params[:id].nil?
      redirect_to root_path
    end 
    @galleries = Gallery.where("project_id" => params[:id])
    @project = Project.find(params[:id])
    @permiso = check_propiety(@project)
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    @project = Project.find(@gallery.project_id)
    add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s    
    add_breadcrumb I18n.t("breadcrumbs.galleries"), '/projects/galleries/' + @project.id.to_s
    @images = Image.where("galery_id = ?", @gallery.id).group(:image_url)
  end

  # GET /galleries/new/:id
  def new
    @project2 = params[:id]
    puts"------------------------------------------------------"
    puts @gallery.inspect
    puts"------------------------------------------------------"
    @gallery = Gallery.new("project_id"=> @project2)
    @project= Project.find(@project2)
        add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s
    add_breadcrumb I18n.t("breadcrumbs.galleries"), '/projects/galleries/' + @project.id.to_s 
    @permiso = check_propiety(@project)
    unless @permiso 
      redirect_to home_path
    end
  end

  # GET /galleries/1/edit/proyecto_id
  def edit
      @project2 = Project.find(@gallery.project_id)
      add_breadcrumb @project2.name.to_s, '/projects/' + @project2.id.to_s
      add_breadcrumb I18n.t("breadcrumbs.galleries"), '/projects/galleries/' + @project2.id.to_s 
      @project = params[:proy]
      @permiso = check_propiety(@project)
    unless @permiso 
      redirect_to home_path
    end
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)
    @project2 = Project.find(params[:gallery][:project_id])

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to '/projects/galleries/' + @project2.id.to_s, notice: 'Gallery was successfully created.' }
        format.json { render :show, status: :created, location: @gallery }
      else
        format.html { render '/projects/galleries/' + @project2.id.to_s }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render '/projects/galleries/' + @project2.id.to_s }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(:title, :description, :project_id)
    end
end
