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

# List subject by User
20.times do
  Subject.create(subject_name: Faker::Lorem.sentence,
    duaration: rand(10..60),
    total_score: rand(10..120),
    limit_questions: rand(10..40),
    create_by: User.all.sample.id)
