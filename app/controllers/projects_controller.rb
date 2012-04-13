class ProjectsController < ApplicationController
  respond_to :json, :except => :show
  respond_to :html, :only => :show
  
  def index
    respond_with Project.all
  end

  def show
    @project = Project.find(params[:id])
    respond_with @project 
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
