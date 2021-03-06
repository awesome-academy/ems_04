FactoryBot.define do
  factory :subject do
    subject_name {Faker::Lorem.word}
    duaration {rand(10..60)}
    total_score {rand(10..120)}
    limit_questions {rand(10..20)}
    user
    factory :invalid_subject do
      subject_name {""}
      duaration {""}
      total_score {""}
      limit_questions {""}
    end
  end
end
