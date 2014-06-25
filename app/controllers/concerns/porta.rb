module Porta
	extend ActiveSupport::Concern
  private
  	#verificamos si el usuario en session es el dueño de los proyectos abiertos
	def check_propiety(proy_id)
	    @project = Project.find(proy_id)

	    if @project.user_id == session[:user_id] && !@project.user_id.nil? && !@project.user_id.blank? 
	        puts "---------porta-----true---------------------------"
    		puts @project.user_id
    		puts session[:user_id]
    		puts "-----------------------------------------"	
	      return true
	    else
	    	puts "---------porta-----false---------------------------"
    		puts @project.user_id
    		puts session[:user_id]
    		puts "-----------------------------------------"
	      return false
	    end 
	end

	#checamos si el usuario es admin
	def check_admin
		if session[:user_id] && session[:mod0]
			@iam = true
		else
			@iam = false
		end	
	end	

end  