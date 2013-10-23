# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ArticleType.create(name: 'articles')
ArticleType.create(name: 'anounses')
ArticleType.create(name: 'news')
Group.create(name: 'administrators', administrator: true, editor: true, viewer: true)
Group.create(name: 'editors', administrator: false, editor: true, viewer: true)
Group.create(name: 'viewers', administrator: false, editor: false, viewer: true)
