20.times do |n|
  User.create(
    name: "Test Diver#{n}",
    nick_name: "Test Diver#{n}",
    email: "diveintocode#{n}@example.com",
    password: "iwillbeanengineer",
    uid: "#{n}",
    provider: ""
    )
end
