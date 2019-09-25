# User.create!(last_name: "Vo",
#   first_name: "Sang",
#   email: "sangvo111@gmail.com",
#   role: User.roles[:admin],
#   bio: "Simple is the best",
#   password: "123456",
#   password_confirmation: "123456")

# User.create!(last_name: "Test",
#   first_name: "Trainee",
#   email: "sangvo@gmail.com",
#   role: User.roles[:trainee],
#   bio: "Trainee",
#   password: "123456",
#   password_confirmation: "123456")

User.create!(last_name: "Test",
  first_name: "Suppervisor",
  email: "suppervisor@gmail.com",
  role: User.roles[:supervisor],
  bio: "Suppervisor",
  password: "123456",
  password_confirmation: "123456")

# List subject by User
20.times do
  Subject.create(subject_name: Faker::Lorem.sentence,
    duaration: rand(10..60),
    total_score: rand(10..120),
    limit_questions: rand(10..40),
    create_by: User.all.sample.id)

# User.create!(last_name: "Test",
#   first_name: "Suppervisor",
#   email: "suppervisor@gmail.com",
#   role: User.roles[:supervisor],
#   bio: "Suppervisor",
#   password: "123456",
#   password_confirmation: "123456")

# # List subject by User
# 20.times do
#   Subject.create(subject_name: Faker::Lorem.sentence,
#     duaration: rand(10..60),
#     total_score: rand(10..120),
#     limit_questions: rand(10..40),
#     create_by: User.all.sample.id)
# end
# # Create question single choice
# 20.times do
# Question.create(question_content: Faker::Lorem.sentence,
#     score: 10,
#     subject_id: Subject.all.sample.id,
#     question_type: 0,
#     create_by: User.all.sample.id)
# end
# # Create answer single choice
# single_choices = Question.where(question_type: 0).pluck(:id)

# single_choices.each do |question|
# Answer.create(answer_content: Faker::Lorem.sentence,
#     is_correct: true,
#     question_id: question)
# end

# 30.times do
# Answer.create(answer_content: Faker::Lorem.sentence,
#     is_correct: false,
#     question_id: Question.all.sample.id)
# end

30.times do
  Question.create(question_content: Faker::Lorem.sentence,
    score: 10,
    subject_id: 12,
    question_type: 1,
    create_by: User.all.sample.id)
end
