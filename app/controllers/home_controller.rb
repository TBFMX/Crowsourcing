class HomeController < ApplicationController
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
