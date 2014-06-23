class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  #before_action :autorizado,  only: [ :edit, :update, :destroy]
  #add_breadcrumb I18n.t("breadcrumbs.comments"), comments_path
    include Porta
  # GET /comments
  # GET /comments.json
  def index
    if params[:id].nil?
      redirect_to root_path
    end 
    @comments = Comment.where("project_id" => params[:id])
    @project = Project.find(params[:id])
    add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s
    add_breadcrumb I18n.t("breadcrumbs.comments"), '/projects/comments/' + @project.id.to_s
    @permiso = check_propiety(@project) 
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @project = Project.find(@comment.project_id)
    add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s
    add_breadcrumb I18n.t("breadcrumbs.comments"), '/comments/' + @comment.id.to_s
  end

  # GET /comments/new/proyecto_id
  def new
    @project2 = params[:id]
    @project = Project.find(@project2)
    add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s
    add_breadcrumb I18n.t("breadcrumbs.comments"), '/projects/comments/' + @project.id.to_s 
    @user = session[:user_id]
    @comment = Comment.new("project_id" => @project2, "user_id"=> @user)
    @permiso = check_propiety(@project)
    unless @permiso 
      redirect_to home_path
    end 
  end

  # GET /comments/1/edit/proyecto_id
  def edit
    @project = params[:proy]
    @permiso = check_propiety(@project)
    unless @permiso 
      redirect_to home_path
    end 
  end

  # POST /comments
  # POST /comments.json
  def create
    add_breadcrumb I18n.t("breadcrumbs.amends"), '/comments/#{params[:comment][:id]/amends/#{params[:comment][:project_id]}'
    @comment = Comment.new(comment_params)

    puts "-------parametros---------"
    puts params.inspect
    puts "--------------------------"

    respond_to do |format|
      if secure_save(@comment) 
        format.html { redirect_to "/projects/" + params[:comment][:project_id].to_s, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render "/projects/" + params[:comment][:project_id].to_s }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to "/projects/" + params[:comment][:project_id].to_s, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render "/projects/" + params[:comment][:project_id].to_s }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :project_id, :comments)
    end
end
