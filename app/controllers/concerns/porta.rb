module Porta
	extend ActiveSupport::Concern
  private
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

end  