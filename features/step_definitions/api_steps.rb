When /^I call the listing projects API$/ do
  visit "/projects"
end

When /^I call the delete the project API$/ do
  delete_resource "/projects/#{current_project.id}"
end

Given /^I create a new project using the API$/ do
  attrib = Fabricate.attributes_for(:project)
  set_current_project Project.new(attrib)
  post '/projects', :format => :json, 'project' => attrib
end
