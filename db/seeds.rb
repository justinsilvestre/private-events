# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create(name: 'Justin Silvestre',
									 email: 'justinsilvestre@gmail.com',
									 password: 'justin',
									 password_confirmation: 'justin');

e1 = u1.events.build({ name: 'Thevent',
											 date: Time.now,
											 description: 'like srsly whoa'})
e1.save

# create multiple users, some with events, some without
# look into faker
# make sure some events are in the past, make sure some are upcoming
# make sure some events have attendees