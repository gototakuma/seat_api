10.times.each do |n|
  User.create!(
    name: "test#{n+1}",
    login_id: "sample#{n+1}",
    password: 'password'
  )
end
puts 'ユーザー作成！'