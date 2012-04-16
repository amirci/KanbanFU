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
      cards = phase.all("card header").map { |c| c.text }
      {phase: phase.find("name").text, cards: cards}
    end
  end
  
  def find_phase(phase_name)
    phases.find { |p| p[:phase] == phase_name }
  end

  def find_card(card)
    CardElement.new(card)
  end
  
  class CardElement
    include PageObject
    
    def initialize(card)
      super(nil)
      @card = card
    end
    
    def change_phase(phase_name)
      card_widget = find(:css, "card header:contains('#{@card.title}')")
      new_phase = find(:css, "phase name:contains('#{phase_name}')")
      card_widget.drag_to(new_phase)
      self
    end
  end
end