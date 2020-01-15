# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(:name => "Captain America", :email => "admin@gmail.com", :password => '123456', :password_confirmation => '123456', :confirmed_at => DateTime.now, role: 0)
(1..10).each do |i|
  User.create!(:name => "Black_widow#{i}", :email => "Black_widow#{i}@gmail.com", :password => '123456', :password_confirmation => '123456', :confirmed_at => DateTime.now, role: 1)
end
(1..5).each do |i|
  Project.create(:name => "project#{i}")
end
(1..10).each do |i|
	(1..5).each do |j|
		Todo.create(:title => "tododev#{i}p#{j}", status: 0, project_id: j, user_id: i)
	end
end
