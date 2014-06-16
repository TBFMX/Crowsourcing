module Porta

	def check_propiety(proy_id)
	    @project = Project.find(proy_id)
	    if @project.user_id == session[:user_id]
	      return true
	    else
	      return false
	    end 
	end

end  