Given /^I have some projects$/ do
  10.times { Fabricate(:project) }
end

Given /^I have the projects:$/ do |table|
  projects = table.hashes.collect { |attributes| Project.create!(attributes) }
end

Given /^I have a project called "([^"]*)"$/ do |project_name|
  set_current_project Fabricate(:project, name: project_name)
end

Then /^the response should indicate the project has been deleted$/ do
  last_json.should be_json_eql("null")
end

Then /^the project should not exist any more$/ do
  Project.find_by_id(current_project.id).should be_nil
end

Then /^the response should contain all existing projects$/ do
  last_json.should be_json_eql({projects: Project.all}.to_json)
end

