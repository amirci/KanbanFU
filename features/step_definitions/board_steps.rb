When /^I display the board$/ do
  BoardPage.new(current_project).navigate
end

Then /^I should see all the project phases$/ do
  current_board.should show_all_the_phases_from current_project
end

Then /^I should see all the cards in the right phases$/ do
  current_board.should show_the_cards_from current_project
end


