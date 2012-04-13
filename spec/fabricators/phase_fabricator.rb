Fabricator(:phase) do
  name        { Faker::Lorem.words(2).join(" ") }
  description { Faker::Lorem.paragraphs(2).join('\n') }
end