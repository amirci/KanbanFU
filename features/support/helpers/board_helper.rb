module BoardHelper
  def current_board
    BoardPage.new(current_project)
  end
  
  RSpec::Matchers.define :show_the_cards_from do |project|
    match do |board|
      false
    end
    
    failure_message_for_should do |board|
      expected = project.cards.map { |c| [c.title, c.phase.name] }
      "The board should show the cards #{expected}"
    end
  end
  
end

World(BoardHelper)