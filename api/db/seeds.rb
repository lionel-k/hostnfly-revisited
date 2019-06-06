# frozen_string_literal: true

Listing.destroy_all
Booking.destroy_all
Reservation.destroy_all
Mission.destroy_all

input = {
  "listings": [
    { "id": 1, "num_rooms": 2 },
    { "id": 2, "num_rooms": 1 },
    { "id": 3, "num_rooms": 3 }
  ],
  "bookings": [
    { "id": 1, "listing_id": 1, "start_date": "2016-10-10", "end_date": "2016-10-15" },
    { "id": 2, "listing_id": 1, "start_date": "2016-10-16", "end_date": "2016-10-20" },
    { "id": 3, "listing_id": 2, "start_date": "2016-10-15", "end_date": "2016-10-20" }
  ],
  "reservations": [
    { "id": 1, "listing_id": 1, "start_date": "2016-10-11", "end_date": "2016-10-13" },
    { "id": 1, "listing_id": 1, "start_date": "2016-10-13", "end_date": "2016-10-15" },
    { "id": 1, "listing_id": 1, "start_date": "2016-10-16", "end_date": "2016-10-20" },
    { "id": 3, "listing_id": 2, "start_date": "2016-10-15", "end_date": "2016-10-18" }
  ]
}


listings = input[:listings]
bookings = input[:bookings]
reservations = input[:reservations]

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
