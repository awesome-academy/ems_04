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
