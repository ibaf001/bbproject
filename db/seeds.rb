User.create!(username: "ibo", email: "ibo@gmail.com", password: "password", password_confirmation: "password", admin: true)

99.times do |n|
  User.create!(username: "user#{n}", email: "user#{n}@example.com" , password: "password", password_confirmation: "password")

end
