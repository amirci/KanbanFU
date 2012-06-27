module CardHelper

  def current_card
    @current_card ||= Fabricate(:card)
  end
  
  module Matchers
    RSpec::Matchers.define :be_in_phase do |phase_name|
      match do |card|
        card.phase.should == Phase.find_by_name(phase_name)
      end

      failure_message_for_should do |card|
        %Q{The card was expected to be in phase "#{phase_name}" but was in phase "#{card.phase.name}"}
      end
    end
  end
  
end

World(CardHelper)