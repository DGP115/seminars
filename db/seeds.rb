# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'Seminars are being seeded'
seminars = Seminar.create ([
  {
    name: 'Seminar 1',
    description: 'Seminar 1 Description',
    start_date: Date.today + 1.days,
    end_date: Date.today + 8.days,
    start_time: '9:00 am',
    end_time: '5:00 pm',
    total_seats: 10,
    remaining_seats: 10,
    registration_fee: 1000
  },
  {
    name: 'Seminar 2',
    description: 'Seminar 2 Description',
    start_date: Date.today + 2.days,
    end_date: Date.today + 9.days,
    start_time: '9:00 am',
    end_time: '5:00 pm',
    total_seats: 10,
    remaining_seats: 10,
    registration_fee: 1000
  },
  {
    name: 'Seminar 3',
    description: 'Seminar 3 Description',
    start_date: Date.today + 10.days,
    end_date: Date.today + 18.days,
    start_time: '9:00 am',
    end_time: '5:00 pm',
    total_seats: 10,
    remaining_seats: 10,
    registration_fee: 1000
  },
  {
    name: 'Seminar 4',
    description: 'Seminar 4 Description',
    start_date: Date.today + 11.days,
    end_date: Date.today + 18.days,
    start_time: '9:00 am',
    end_time: '5:00 pm',
    total_seats: 10,
    remaining_seats: 10,
    registration_fee: 1000
  },
  {
    name: 'Seminar 5',
    description: 'Seminar 5 Description',
    start_date: Date.today + 15.days,
    end_date: Date.today + 18.days,
    start_time: '9:00 am',
    end_time: '5:00 pm',
    total_seats: 10,
    remaining_seats: 10,
    registration_fee: 1000
  }
])
puts 'Seminar seeding is done'
