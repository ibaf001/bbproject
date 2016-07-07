User.create!(username: "ibo", email: "ibo@gmail.com", password: "password", password_confirmation: "password", admin: true, activated: true, activated_at: Time.now)

99.times do |n|
  User.create!(username: "user#{n}", email: "user#{n}@example.com" , password: "password", password_confirmation: "password",activated: true, activated_at: Time.now)

end
