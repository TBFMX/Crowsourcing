class SessionsController < ApplicationController

  skip_before_action :authorize

  def new
  end

  def create
  	user = User.find_by(username: params[:username])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
      session[:uname] = params[:username]
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


  		redirect_to session[:lasurl]
  	else
  		redirect_to root_path, alert: "Invalid user/password combination"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path, notice: "Logged out"
  end
end
