class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :autorizar
  skip_before_action :autorizar, only:[:new,:create]
  skip_before_action :authorize, only:[:new,:create]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if secure_save(@user)
        format.html { #redirect_to "/login", alert: 'Usuario creado' 
          user = User.find(@user)
          if user and user.authenticate(params[:password])
            session[:user_id] = user.id
            session[:uname] = params[:username]
            session[:user_name_complete] = user.nombre
            session[:rol_id] = user.rol_id

            #variables de rol
            rol =Rol.find_by(id: user.rol_id)
            unless rol.nil?
              session[:mod0] =rol.admin
              session[:mod1] =rol.module_1
              session[:mod2] =rol.module_2
              session[:mod3] =rol.module_3
              session[:mod4] =rol.module_4
              session[:mod5] =rol.module_5
            end
            #termina variables de rol
            if session[:lasurl]
              redirect_to session[:lasurl], notice: "Session iniciada"
            else
              redirect_to root_path, notice: "Session iniciada"
            end
          else
            redirect_to root_path, alert: "Invalid user/password combination"
          end
        }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, alert: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reset_password
    @user = User.where(["username= ? and email= ?",params[:username],params[:email]])
    @user.update(user_params)
    Mailer.reset_password(@user,params[:email]).deliver
  end

  def cambiar_password
    @user = User.find(params[:id])
    Mailer.cambiar_password(@user).deliver  
  end

  def recover_password
    @user = User.where(["username= ? and email= ?",params[:username],params[:email]])
    if @user.empty?
      redirect_to root_path
    else
      #puts @user.inspect
      Mailer.recover_password(@user,params[:email]).deliver
      redirect_to users_url
    end   
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def autorizar
      unless session[:mod0] == true     
        redirect_to root_path
      end
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email, :nombre)
    end
end
