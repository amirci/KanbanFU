module ProjectHelper 
  
  def current_project
    @current_project
  end

  def set_current_project(some_project)
    @current_project = some_project
  end  
end

World(ProjectHelper)