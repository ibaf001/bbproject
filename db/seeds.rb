User.create!(username: "ibo", email: "ibo@gmail.com", password: "password", password_confirmation: "password", admin: true, activated: true, activated_at: Time.now)

99.times do |n|
  User.create!(username: "user#{n}", email: "user#{n}@example.com" , password: "password", password_confirmation: "password",activated: true, activated_at: Time.now)

end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content)}

end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
