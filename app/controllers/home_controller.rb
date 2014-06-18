class HomeController < ApplicationController
skip_before_action :authorize
  def index
  	@project = Project.all
  end

  def about
  end

  def contact
  end

  def projects
  end
end
