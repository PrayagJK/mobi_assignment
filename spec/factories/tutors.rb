
  FactoryBot.define do
    factory :tutor do
      first_name { "John" }
      last_name { "Doe" }
      specialization { "Physics" }
      association :course
    end
  end