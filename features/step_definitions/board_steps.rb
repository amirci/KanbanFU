Then /^I should see all the project phases$/ do
  expected = current_project.phases.map { |p| p.name }
  current_board.phases_names.should == expected
end

Then /^I should see all the cards in the right phases$/ do
  current_board.should show_the_cards_from current_project
end


