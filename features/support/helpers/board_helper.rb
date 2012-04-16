module BoardHelper
  def current_board
    BoardPage.new(current_project)
  end
  
  RSpec::Matchers.define :show_all_the_phases_from do |project|
    match do |board|
      board.phases.map { |p| p[:phase] }.should == project.phases.map(&:name)
    end
  end
  
  RSpec::Matchers.define :show_the_cards_from do |project|
    match do |board|
      board.phases.should == expected_phases(project)
    end
    
    failure_message_for_should do |board|
      phase_message = lambda { |p| "\n- Phase: #{p[:phase]} -> #{p[:cards].join(', ')}" }
      "The board should show the phases with cards" +
        expected_phases(project).map(&phase_message).join +
        "\n but is showing" +
        board.phases.map(&phase_message).join
    end

    def expected_phases(project)
      project.phases.map do |phase|
        {phase: phase.name, cards: phase.cards.map(&:title)}
      end
    end
  end
  
end

World(BoardHelper)