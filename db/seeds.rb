10.times.each do |n|
  User.create!(
    name: "test#{n+1}",
    login_id: "sample#{n+1}",
    password: 'password'
  )
end
puts 'ユーザー作成！'

Shop.create!(
  name: 'コワーキングスペース品川店',
  login_id: 'shop1',
  password: 'password',
  address: '東京都品川区大井'
)
puts '店舗作成！'

Seat.create!(
  number: 1,
  seat_type: 'リクライニング',
  shop_id: 1
)
Seat.create!(
  number: 2,
  seat_type: '座敷',
  shop_id: 1
)
Seat.create!(
  number: 3,
  seat_type: 'PC + リクライニング',
  shop_id: 1
)
puts '座席作成！'