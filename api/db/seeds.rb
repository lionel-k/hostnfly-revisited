# frozen_string_literal: true

Listing.destroy_all
Booking.destroy_all
Reservation.destroy_all
Mission.destroy_all

filename = Dir[File.join(Rails.root, 'db', 'backend_test.rb')][0]
puts "Seeding from #{filename}"
load(filename) if File.exist?(filename)

listings = INPUT[:listings]
bookings = INPUT[:bookings]
reservations = INPUT[:reservations]

listings.each do |listing|
  Listing.create!(num_rooms: listing[:num_rooms])
end

bookings.each do |booking|
  Booking.create!(listing: Listing.find(booking[:listing_id]),
    start_date: booking[:start_date],
    end_date: booking[:end_date]
    )
end

reservations.each do |reservation|
  Reservation.create!(listing: Listing.find(reservation[:listing_id]),
    start_date: reservation[:start_date],
    end_date: reservation[:end_date]
    )
end
