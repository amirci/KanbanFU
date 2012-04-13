require_relative 'page_object'

class BoardPage
  include PageObject
  
  def initialize(project)
    @project = project
    super(nil)
  end
  
  def navigate
    visit "/projects/#{@project.id}"
    self
  end
  
  def phases_names
    all(:css, "phase name").map { |e| e.text }
  end

  def cards_titles
    all(:css, "card title").map { |e| e.text }
  end
  
end