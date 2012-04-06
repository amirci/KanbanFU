Fabricator(:project) do
  name        { Faker::Lorem.words(2).join('_') }
  description { Faker::Lorem.paragraphs(2) }
end