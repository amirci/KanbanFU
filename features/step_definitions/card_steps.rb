Given /^I have the cards for project "([^"]*)":$/ do |project_id, table|
  project = Fabricate(:project, id: project_id)
  project.phases << Fabricate(:phase)
  table.hashes.each do |attr| 
    project.phases.first.cards.create!(attr)
  end
end

Given /^I post to "\/cards" for project "([^"]*)" with:$/ do |project_id, table|
  project = Fabricate(:project, id: project_id)
  project.phases << Fabricate(:phase)
  post_resource "/projects/#{project_id}/cards", 'card', table.hashes
end

Given /^I have a card on phase "([^"]*)"$/ do |phase_name|
  Phase.find_by_name(phase_name).cards << current_card
end

When /^I put to "\/cards" for project "([^"]*)" and card "([^"]*)" with:$/ do |project_id, card_id, table|
  project = Project.create!(id: project_id, name: "Blazing Saddles", description: "Good movie")
  put_resource "/projects/#{project_id}/cards/#{card_id}", 'card', table.hashes
end

When /^I delete card "([^"]*)" for project "([^"]*)"$/ do |card_id, project_id|
  project = Project.create!(id: project_id, name: "Blazing Saddles", description: "Good movie")
  delete_resource "/projects/#{project_id}/cards/#{card_id}"
end

When /^I move the card to phase "([^"]*)"$/ do |phase_name|
  current_board
    .find_card(current_card)
    .change_phase(phase_name)
end

Then /^the card phase should be "([^"]*)"$/ do |phase_name|
  current_board.find_phase(phase_name).should show_card(current_card)
  current_card.should be_in_phase(phase_name)
end

