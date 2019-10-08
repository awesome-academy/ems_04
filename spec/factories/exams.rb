FactoryBot.define do
  factory :exam do
    start_time {Time.zone.now}
    finish_time {Time.zone.now + 60}
    status {Exam.statuses.key(Exam.statuses[:start])}
    user
    subject
  end
end
