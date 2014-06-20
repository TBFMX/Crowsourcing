class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  #before_action :autorizado,  only: [ :edit, :update, :destroy]
      include Porta

  # GET galleries/images/1
  # GET /images.json
  def index
    if params[:id].nil?
      redirect_to root_path
    end  
    @images = Image.where("galery_id" => params[:id])
    @gallery =Gallery.find(params[:id])
    @project = Project.find(@gallery.project_id)
    @permiso = check_propiety(@project)

  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new/galleria_id
  def new
    @gallery =Gallery.find(params[:id])
    @project = Project.find(@gallery.project_id)
    add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s
        add_breadcrumb I18n.t("breadcrumbs.galleries"), '/projects/galleries/' + @project.id.to_s 
    add_breadcrumb I18n.t("breadcrumbs.images"), '/images/new/' + @project.id.to_s 
    @image = Image.new("galery_id" => params[:id])
    @permiso = check_propiety(@project)
    unless @permiso 
      redirect_to root_path
    end
  end

  # GET /images/1/edit/
=begin  
  def edit
      
  end
=end
  # POST /images
  # POST /images.json
  def create
    @pic = params[:image][:image_url]
    puts "---------------------------------datos-imagen------------------------------------------------------"
    puts pic.inspect
    puts "---------------------------------------------------------------------------------------------------"

    @gallery = Gallery.find(params[:image][:galery_id])
    @project2 = Project.find(@gallery.project_id)
    @gallery2 = Gallery.find(@gallery)
    @pics = DataFile.save(@pic,@project2.name,@gallery2.title)

    @image = Image.new("image_url" => @pics, "galery_id" => params[:image][:galery_id])

    respond_to do |format|
      if @image.save
        format.html { redirect_to '/galleries/' + params[:image][:galery_id].to_s, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to '/galleries/' + params[:galery_id].to_s, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:image_url, :galery_id)
    end
end
