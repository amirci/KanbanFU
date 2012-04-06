When /^I call the API to delete the project$/ do
  delete_resource "/projects/#{current_project.id}"
end

Then /^the response should indicate the project has been deleted$/ do
  last_json.should be_json_eql("null")
end
