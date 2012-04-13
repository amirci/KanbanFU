Fabricator(:phase) do
  name        { %w(Analysis Working Review QA Design Coding).sample + "_" + Faker::Lorem.words(1).first }
  description { Faker::Lorem.paragraphs(1) }
  
  cards!(count: 2)
end

