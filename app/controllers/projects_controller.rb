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
    resource_found?(project) do |p|
      destroyed = p.destroy
      render_json(destroyed ? {} : nil, :error_code => :error)
    end
  end
  
end
