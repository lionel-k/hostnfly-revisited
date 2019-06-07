# HostnFly Revisited API

### To run the API in local environment

- `git clone https://github.com/lionel-k/hostnfly-revisited.git`
- `cd hostnfly-revisited/api`
- `bundle`
- `rails db:create` - Create the db
- `rails db:migrate` - Create the db schema
- `rails db:seed` (optional) - To populate the database with fake data.
- `rails s` - To launch the localhost server.
- `rspec` - To run the tests.

The script to fill the database from the `backend_test.rb` is in `db/seeds.rb`

### Database schema

![alt text](https://raw.githubusercontent.com/lionel-k/hostnfly-revisited/master/api/public/database-schema.png)

### Available Endpoints

#### Listings

- `GET /listings`
- `POST /listings`
- `GET /listings/:id`
- `PUT /listings/:id`
- `DELETE /listings/:id`

#### Bookings

- `GET /listings/:listing_id/bookings`
- `POST /listings/:listing_id/bookings`
- `GET /listings/:listing_id/bookings/:id`
- `PUT /listings/:listing_id/bookings/:id`
- `DELETE /listings/:listing_id/bookings/:id`

#### Reservations

- `GET /listings/:listing_id/reservations`
- `POST /listings/:listing_id/reservations`
- `GET /listings/:listing_id/reservations/:id`
- `PUT /listings/:listing_id/reservations/:id`
- `DELETE /listings/:listing_id/reservations/:id`

#### Missions

- `GET /missions`
