20.times do |n|
  Topic.create(
    title: "title#{n}",
    content: "content#{n}",
    user_id: rand(10) + 1
  )
end
