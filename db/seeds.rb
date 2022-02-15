# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Organization.destroy_all
Event.destroy_all

organization = Organization.create!(name: "ARC", location: "Denver, CO", phone: "928-779-7857", email: "denver@arc.org")
organization2 = Organization.create!(name: "Ted's Org", location: "Denver, CO", phone: "928-779-7857", email: "tstaros23@gmail.com")
organization3 = Organization.create!(name: "Matt's Org", location: "Denver, CO", phone: "928-779-7857", email: "ilookup@gmail.com")
event1 = Event.create!(name: 'Soup Kitchen', category: 1, address: '1625 Fenton St., Lakewood CO 80214', description: 'Good food', vols_required: 5, phone: 9287787857, organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
event2 = Event.create!(name: 'Blood Drive', category: 2, address: '5280 Wadsworth Blvd, Arvada CO', description: 'Good blood', vols_required: 1, phone: 9287787857,organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
event3 = Event.create!(name: 'Homeless Living', category: 2, address: '2136 Champa St, Denver, CO 80205', description: 'Good blood', vols_required: 1, phone: 9287787857, organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
