module BoardHelper
  def current_board
    BoardPage.new(current_project)
  end

  module Matchers
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
        project.phases.map { |phase| {phase: phase.name, cards: phase.cards.map(&:title)} }
      end
    end
    
    RSpec::Matchers.define :show_card do |card|
      match do |phase|
        Rails.logger.debug { "**** Match phase #{phase[:cards].inspect}" }
        phase[:cards].index(card.title).should_not be_nil
      end

      failure_message_for_should do |phase|
        actual = phase[:cards].join(', ')
        "The board should show phase '#{phase[:phase]}' including card '#{card.title}'" +
        (actual.empty? ? 
            "\nbut it has no cards at all" : 
            "\nbut is is showing cards '#{actual}'")
      end
    end
  end

end

World(BoardHelper)