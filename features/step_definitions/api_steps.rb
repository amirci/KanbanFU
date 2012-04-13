When /^I call the listing projects API$/ do
  get_resource "/projects"
end

When /^I call the delete the project API$/ do
  delete_resource "/projects/#{current_project.id}"
end

Given /^I create a new project using the API$/ do
  attrib = Fabricate.attributes_for(:project)
  set_current_project Project.new(attrib)
  post '/projects', :format => :json, 'project' => attrib
end

When /^I get all the cards for project (\d+) using the API$/ do |project_id|
  visit "/projects/#{project_id}/cards"
end

When /^I get card (\d+) for project (\d+) using the API$/ do |card_id, project_id|
  visit "/projects/#{project_id}/cards/#{card_id}"
end
