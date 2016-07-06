User.create!(username: "admin", email: "admin@admin.com", password: "password", password_confirmation: "password")

99.times do |n|
  User.create!(username: "user#{n}", email: "user#{n}@example.com" , password: "password", password_confirmation: "password")

end
