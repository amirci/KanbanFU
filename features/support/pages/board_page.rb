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
  
  def phases
    all(:css, "phase").map do |phase| 
      cards = phase.all("card title").map { |c| c.text }
      {phase: phase.find("name").text, cards: cards}
    end
  end
  
end