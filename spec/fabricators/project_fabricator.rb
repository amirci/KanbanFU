Fabricator(:project) do
  name        { Faker::Lorem.words(2).join(" ") }
  description { Faker::Lorem.paragraphs(2).join('\n') }
end

Fabricator(:full_project, :from => :project) do
  cards(count: 10)
  phases! { Faker::Lorem.words(3).map { |t| Fabricate(:phase, name: t) } }
end