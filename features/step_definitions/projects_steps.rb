Given /^I have the projects:$/ do |table|
  projects = table.hashes.collect { |attributes| Project.create!(attributes) }
end

Given /^I post to "\/projects" with:$/ do |table|
  post_resource('/projects', 'project', table.hashes)
end

Given /^I have a project called "([^"]*)"$/ do |project_name|
  set_current_project Fabricate(:project, name: project_name)
end

Then /^the project should not exist any more$/ do
  pending # express the regexp above with the code you wish you had
end