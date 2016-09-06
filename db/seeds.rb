20.times do |n|
  User.create(
    name: "Test Diver#{n}",
    nick_name: "Test Diver#{n}",
    email: "diveintocode#{n}@example.com",
    password: "iwillbeanengineer",
    uid: "#{n}",
    provider: ""
    )

  Topic.create(
    title: "Title#{n}",
    content: "Content#{n}",
    user_id: (n + 10)
  )

  Comment.create(
    content: "Content#{n}",
    user_id: (n + 10),
    topic_id: (n + 3)
  )
end
