# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'Caio Torres', page: 'http://about.me/caiotorres')

Post.create(user_id: 1, slug: 'last-post', title: 'Last Post', subtitle: 'Finish it', content: "<h1>Last Section</h1><p>Thw test is over.</p>", published: true, published_at: Time.now)
Post.create(user_id: 1, slug: 'argument-about-life', title: 'Argument about life', content: "<h1>Seize the day</h1><p>I heard him say.</p>", published: true, published_at: Time.now - 2.days)
Post.create(user_id: 1, slug: 'first-post', title: 'First Post', subtitle: 'First ever post', content: "<h1>Only Section</h1><p>This is a test post.</p>", published: true, published_at: Time.now - 10.days)
