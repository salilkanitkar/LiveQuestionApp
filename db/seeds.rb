# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([{username: "admin-admin", password: "cannot delete me", name: "Admin", email: "askuery@gmail.com", isadmin: 1},
            {username: "admin-salil", password: "is hard to crack", name: "Salil", email: "sskanitk@ncsu.edu", isadmin: 1},
            {username: "admin-mohanish", password: "is hard to crack", name: "Mohanish", email: "mhkulkar@ncsu.edu", isadmin: 1}])
