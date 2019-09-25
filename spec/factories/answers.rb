FactoryBot.define do
  factory :answer do
    answer_content {Faker::Book.title}
    is_correct {Faker::Boolean.boolean}
    association :question
  end
end
