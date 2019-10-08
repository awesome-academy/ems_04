FactoryBot.define do
  factory :user do
    last_name {Faker::Name.last_name}
    first_name {Faker::Name.first_name}
    email {Faker::Internet.email}
    bio {Faker::Lorem.word }
    photo {Faker::Avatar.image(slug: "avatar", size: "50x50", format: "jpg")}
    password {"123456"}
    password_confirmation {"123456"}
    role {User.roles.key(User.roles[:admin])}
    factory :admin do
      role {User.roles.key(User.roles[:admin])}
    end
  end
end

