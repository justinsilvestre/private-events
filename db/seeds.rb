
u1 = User.create(name: 'Justin Silvestre',
									 email: 'justinsilvestre@gmail.com',
									 password: 'justin',
									 password_confirmation: 'justin')


# create 25 more users
(1..25).each do |n|
	name = Faker::Name.name
	email = "example#{n}@example.com"
	password = "password"
	User.create!(name: name, email: email, password: password, password_confirmation: password)
end

# create 10 events within 6 months of today, created by one of the first 5 users
(1..10).each do |n|
	user = User.find(1 + rand(5))
	event = user.events.create!(name: Faker::Lorem.words(2+rand(4)).map(&:capitalize).join(" "), description: Faker::Lorem.paragraphs(2+rand(7)).join("\n\n"),
		date: Faker::Date.between(6.months.ago, 6.months.from_now), location: Faker::Address.street_address)
	# give event up to 25 attendees
	(1+rand(24)).times do |m|
		attendance = event.attendances.build(attendee_id: m)
		attendance.save
	end
end

	


