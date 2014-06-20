class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  #before_action :autorizado,  only: [ :edit, :update, :destroy]
  skip_before_action :authorize, only:[:show, :index]
  include Porta

  # GET /projects
  # GET /projects.json
  def index
    #if params[:id].nil?
    #  redirect_to root_path
    #end 
    @projects = Project.all
    @permiso = check_propiety(@project)
   
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @image = Image.find(@project.image_id)
    @perks = Perk.where("project_id = ?",@project.id).order("price")
    @permiso = check_propiety(@project)
    puts "---------permiso--------------------------------"
    puts @permiso
    puts "-----------------------------------------"
    add_breadcrumb @project.name.to_s, '/projects/' + @project.id.to_s
  end

  # GET /projects/new
  def new
    @project = Project.new
    @user = session[:user_id]
    # @permiso = check_propiety(@project)
    # unless @permiso 
    #   redirect_to root_path
    # end
  end

  # GET /projects/1/edit
  def edit
     @user = session[:user_id]

     puts"------------------------------------------------------"
     puts @user.inspect
     puts"------------------------------------------------------"
     @permiso = check_propiety(@project)
    unless @permiso 
      redirect_to root_path
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    puts "-------------------Proyecto---------------------------"
      puts @project.inspect
     puts "----------------------------------------------"
     @pic = params[:project][:image_id]
    puts "-------------------Pic---------------------------"
      puts @pic.inspect
     puts "----------------------------------------------"

    unless @pic.nil?
      @pics = DataFile.save(@pic,[:project][:name],"principal")
    else
      @pics = ""  
    end
    puts "-------------------Pics---------------------------"
      puts @pics.inspect
    puts "--------------------------------------------------" 
    respond_to do |format|
      if @project.save
        format.html { 
          #saco la id del proyecto
          @projects = Project.find(@project)
          puts "-------------------Proyecto---------------------------"
          puts @projects.inspect
          puts "------------------------------------------------------"
          
          #creo la galleria
          @gallery=Gallery.new("project_id"=>@projects.id, "title" =>"principal", "description"=>"galeria principal del proyecto")
          puts "--------------------Galleria--------------------------"
          puts @gallery.inspect
          puts "------------------------------------------------------"
          respond_to do |format|
            if @gallery.save
              format.html {
                @galleries = Gallery.find(@gallery)
                @image = Image.new("galery_id" => @galleries.id, "image_url" => @pics)
                puts "--------------------Imagen--------------------------"
                puts @image.inspect
                puts "----------------------------------------------------"
                
                respond_to do |format|
                  if @image.save
                    format.html { 
                      respond_to do |format|
                        if @projects.update("image_id" => @image.id)
                          format.html { 
                            #creo un nuevo perk
                            @perk = Perk.new("project_id"=>@projects.id)
                            puts "--------------------Perk--------------------------"
                            puts @perk.inspect
                            puts "--------------------------------------------------"
                            respond_to do |format|
                              if @perk.save
                                format.html { redirect_to '/perks/' + @perk.id.to_s + '/edit/' + @project.id.to_s }
                                format.json {  }
                              end
                            end
                           }
                          format.json { }
                        end
                      end                      
                    }
                    format.json { }
                  end
                end



               }
              format.json {  }
            end
          end


          
          }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def uploadFile
    post = DataFile.save(params[:upload])
    render :text => "File has been uploaded successfully"
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @pic = params[:project][:image_id]
    puts "-------------------Pic---------------------------"
      puts @pic.inspect
    puts "----------------------------------------------"
    respond_to do |format|
      if @project.update(project_params)
        format.html {
          unless @pic.nil?
            @projects = Project.find(@project)
            @pics = DataFile.save(@pic)
            puts "-------------------Pics---------------------------"
              puts @pics.inspect
            puts "--------------------------------------------------"
            unless @project.image.image_url.to_s == @pics.to_s
              @gallery=Gallery.where("project_id = ? ",@projects.id).first
              puts "--------------------Galleria--------------------------"
              puts @gallery.inspect
              puts "------------------------------------------------------"
              respond_to do |format|
                if @gallery.save
                  format.html {
                    @galleries = Gallery.find(@gallery)
                    @image = Image.new("galery_id" => @galleries.id, "image_url" => @pics)
                    puts "--------------------Imagen--------------------------"
                    puts @image.inspect
                    puts "----------------------------------------------------"
                    
                    respond_to do |format|
                      if @image.save
                        format.html { 
                          respond_to do |format|
                            if @projects.update("image_id" => @image.id)
                              format.html { 
                               #aqui continua
                               redirect_to @project , notice: 'El proyecto se edito exitosamente.'
                              }
                              format.json { }
                            end
                          end                      
                        }
                        format.json { }
                      end
                    end 
                  }            
                  format.json { }
                end
              end 
            end
          else
            #en caso de que no se haya movido la imagen
            redirect_to @project , notice: 'El proyecto se edito exitosamente.'
          end  
        }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :monetary_goal, :init_date, :finish_date, :image_id, :user_id)
    end
=begin    
    def check_propiety(proy_id)
      @project = Project.find(proy_id)
      if @project.user_id == session[:user_id]
        return true
      else
        return false
      end 
    end
=end    
end
