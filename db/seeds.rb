User.first_or_create(email: "testemail@example.com", password: Devise.friendly_token.first(6))

20.times do |i|
  WorkingTime.create(date: Date.today + ((1..30)&.to_a&.sample).days, start_time: %w[07:00 08:00 09:00 10:00].sample, duration: (1..8).to_a.sample, user: User.last, title: "Title #{i}", description: "Description #{i}")
end
