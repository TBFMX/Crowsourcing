class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  #before_action :autorizado,  only: [ :edit, :update, :destroy]
    include Porta

  # GET /videos
  # GET /videos.json
  def index
    if params[:id].nil?
      redirect_to root_path
    end 
    @videos = Video.where("galery_id" => params[:id])
    @gallery = Gallery.find(params[:id])
    @project = Project.find(@gallery.project_id)
      add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s
      add_breadcrumb I18n.t("breadcrumbs.videos"), '/projects/galleries/' + params[:id].to_s 
    @permiso = check_propiety(@project)
     
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new/galeria_id
  def new
    @gallery = params[:id]
    @video = Video.new("galery_id" => @gallery)
    @gallery3 = Gallery.find(params[:id])
    @project = Project.find(@gallery3.project_id)
    @permiso = check_propiety(@project)
    unless @permiso 
      redirect_to root_path
    end
  end

  # GET /videos/1/edit
  def edit
    @gallery = params[:id]
    @gallery3 = Gallery.find(params[:id])
    @project = Project.find(@gallery3.project_id)
    @permiso = check_propiety(@project)
    unless @permiso 
      redirect_to root_path
    end
  end

  # POST /videos
  # POST /videos.json
  def create
    @pic = params[:video][:video_url]
    @pics = DataFile.save(@pic)


    @video = Video.new("video_url" => @pics,"galery_id" => params[:video][:galery_id])
    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:video_url, :galery_id)
    end
end
