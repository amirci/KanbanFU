class ProjectsController < ApplicationController
  respond_to :json
  
  def index
    respond_with Project.all
  end
    
  def create
    project = Project.new(params[:project])
    project.save
    respond_with project
  end
  
  def destroy
    project = Project.find(params[:id])
    project.destroy if project
    respond_with project
  end 
end
