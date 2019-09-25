FactoryBot.define do
  factory :question do
    question_content {Faker::Lorem.sentence}
    score {10}
    question_type {Question.question_types.key(Question.question_types[:single_choice])}
    create_by {User.first.id}
    subject_id {Subject.first.id}
    association :user, :subject
  end
end
