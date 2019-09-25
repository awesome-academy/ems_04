User.create!(last_name: "Vo",
  first_name: "Sang",
  email: "sangvo111@gmail.com",
  role: User.roles[:admin],
  bio: "Simple is the best",
  password: "123456",
  password_confirmation: "123456")

User.create!(last_name: "Test",
  first_name: "Trainee",
  email: "sangvo@gmail.com",
  role: User.roles[:trainee],
  bio: "Trainee",
  password: "123456",
  password_confirmation: "123456")

User.create!(last_name: "Test",
  first_name: "Suppervisor",
  email: "suppervisor@gmail.com",
  role: User.roles[:supervisor],
  bio: "Suppervisor",
  password: "123456",
  password_confirmation: "123456")

user_ad =  User.find_by email: "sangvo111@gmail.com"
# List subject by User
5.times do |idx|
  Subject.create(subject_name: "Rails #{idx}",
    duaration: rand(10..60),
    total_score: rand(10..120),
    limit_questions: rand(10..20),
    create_by: user_ad.id)
end

# Create question single choice
subject = Subject.first
40.times do
Question.create(question_content: Faker::Lorem.sentence,
    score: 10,
    subject_id: subject.id,
    question_type: 0,
    create_by: User.all.sample.id)
end

# Create answer single choice
single_choices = Question.where(question_type: 0).pluck(:id)

single_choices.each do |question|
  Answer.create(answer_content: Faker::Lorem.sentence,
    is_correct: true,
    question_id: question)
end


120.times do
Answer.create(answer_content: Faker::Lorem.sentence,
    is_correct: false,
    question_id: Question.all.sample.id)
end

# Create question multi choice
subject = Subject.first

20.times do
Question.create(question_content: Faker::Lorem.sentence,
    score: 10,
    subject_id: subject.id,
    question_type: 1,
    create_by: User.all.sample.id)
end

multi_choices = Question.where(question_type: 1).pluck(:id)

50.times do
  Answer.create(answer_content: Faker::Lorem.sentence,
    is_correct: rand(0..1),
    question_id: multi_choices.sample)
end
