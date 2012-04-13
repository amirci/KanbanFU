Fabricator(:project) do
  name        { Faker::Lorem.words(2).join(" ") }
  description { Faker::Lorem.paragraphs(2).join('\n') }
end

Fabricator(:full_project, :from => :project) do
  phases!(count: 3)
end