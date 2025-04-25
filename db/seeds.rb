# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "IPS posts e logins..."


ips = 50.times.map { |i| "192.168.0.#{i}" }
logins = 100.times.map { Faker::Internet.unique.username }


def create_post(title, body, ip, login)
  json_data = {
                post: {
                  title: title,
                  body: body,
                  ip: ip
                },
                user: {
                  login: login
                }
              }.to_json
  curl_command = <<-CURL
    curl -s -X POST http://localhost:3000/api/v1/posts \\
      -H "Content-Type: application/json" \\
      -d '#{json_data}'
  CURL


  result = `#{curl_command}`
  JSON.parse(result) rescue nil
end


def create_rating(post_id, user_id, value)
  curl_command = <<-CURL
    curl -s -X POST http://localhost:3000/api/v1/ratings \\
      -H "Content-Type: application/json" \\
      -d '{
        "rating": {
          "post_id": #{post_id},
          "user_id": #{user_id},
          "value": #{value}
        }
      }'
  CURL

  result = `#{curl_command}`
  JSON.parse(result) rescue nil
end

puts "Criando posts, usuarios e ratings..."


success = 0
failures = 0

250000.times do |i|
  login = logins.sample
  title = "This title number : #{i}"
  body = Faker::Lorem.paragraph(sentence_count: 3)
  ip = ips.sample


  post_data = create_post(title, body, ip, login)

  if post_data && post_data['post'] && post_data['post']['id']
    success += 1

    if rand < 0.75
      rand(3..5).times do
        value = rand(1..5)
        create_rating(post_data['post']['id'], rand(1..100), value)
      end
    end
  else
    failures += 1
  end


  puts "Criados: #{i + 1}" if (i + 1) % 1000 == 0
end

puts "Total de posts criados com sucesso: #{success}"
puts "Total de posts com erro: #{failures}"
