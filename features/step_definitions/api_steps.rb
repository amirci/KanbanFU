When /^I call the API to delete the project$/ do
  delete_resource "/projects/#{current_project.id}"
end

Then /^the response should indicate the project has been deleted$/ do
  pending # express the regexp above with the code you wish you had
end
