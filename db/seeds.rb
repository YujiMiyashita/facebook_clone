20.times do |n|
  Topic.create(
    content: "content#{n}",
    user_id: rand(10..18),
    topic_id: rand(5..13)
  )
end
