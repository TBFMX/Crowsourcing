class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @image = Image.find(@project.image_id)
    @perks = Perks.where("project_id =",@project.id)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
     @pic = params[:project][:image]
    puts "-------------------Pic---------------------------"
      puts @pic.inspect
     puts "----------------------------------------------"

    #unless params[:image].nil?
      @pics = DataFile.save(@pic)
    #end
        puts "-------------------Pics---------------------------"
      puts @pics.inspect
     puts "----------------------------------------------" 
    respond_to do |format|
      if @project.save
        format.html { 
          #saco la id del proyecto
          @projects = Project.find(@project)
          puts "-------------------Proyecto---------------------------"
          puts @projects.inspect
          puts "----------------------------------------------"
          
          #creo la galleria
          @gallery=Gallery.new("project_id"=>@projects.id)
          puts "--------------------Galleria--------------------------"
          puts @gallery.inspect
          puts "----------------------------------------------"
          respond_to do |format|
            if @gallery.save
              format.html {
                @galleries = Gallery.find(@gallery)
                @image = Image.new("galery_id" => @galleries.id, "image_url" => @pics)
                puts "--------------------Imagen--------------------------"
                puts @image.inspect
                puts "----------------------------------------------"
                
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
                            puts "----------------------------------------------"


                            respond_to do |format|
                              if @perk.save
                                format.html { redirect_to edit_perk_path(@perk) }
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
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
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
      params.require(:project).permit(:name, :monetary_goal, :init_date, :finish_date)
    end
end
