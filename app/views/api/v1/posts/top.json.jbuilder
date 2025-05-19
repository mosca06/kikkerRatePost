json.array! @posts do |post|
  json.id             post.id
  json.title          post.title
  json.body           post.body
  json.average_rating post.average_rating.to_f.round(2)
end
