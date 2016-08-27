30.times do |n|
  User.create(
    name: "Test Diver#{n}",
    nick_name: "Test Diver#{n}",
    email: "diveintocode#{n}@example.com",
    password: "iwillbeanengineer",
    uid: "#{n}"
  )
end

30.times do |n|
  Topic.create(
    title: "Test Topic#{n}",
    content: "もうすぐメンターからティーチャーへ昇格！",
    user_id: (n + 1)
  )
end
