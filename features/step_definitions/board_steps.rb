Then /^I should see all the project phases$/ do
  actual = BoardPage.new(current_project).phases_names
  expected = current_project.phases.map { |p| p.name }
  actual.should == expected
end

Then /^I should see each card on its phase$/ do
  pending # express the regexp above with the code you wish you had
end


