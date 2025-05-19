ips_group = @ips.group_by(&:ip)

json.array! ips_group do |ip, posts|
  json.ip ip
  json.logins posts.map(&:login).uniq
end
