When /^I go to the board$/ do
  BoardPage.new(current_project).navigate
end
