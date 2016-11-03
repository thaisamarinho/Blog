10.times do
  Category.create({ title: Faker::Commerce.department })
end

5.times do
  User.create({first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                password: '123'})
end



cat = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

10.times do
  Tag.create(name: Faker::GameOfThrones.house)
end

tags = Tag.all
users = User.all


100.times do
  p = Post.create({ title: Faker::Hipster.sentence,
                body: Faker::Lorem.paragraph,
                category_id: cat.sample,
                tags:  tags.sample(rand(3) + 1)
                })
  p.stars = users.map{|u| Star.new(count: rand(6), user: u, post: p)}
end
