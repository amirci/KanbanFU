class ProjectsController < ApplicationController
  respond_to :json

  def index
    render_json({projects: Project.all})
  end
    
  def create
    project = Project.new(params[:project])
    project.save
    render_json({project: project})
  end
  
  def destroy
    project = Project.find_by_id(params[:id])
    project.destroy
    render_json({})
    # resource_found?(resource) do |project|
    #   project.destroy
    #   render_json({})
    # end
  end
  
end
