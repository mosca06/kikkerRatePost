json.post do
  json.id            @post.id
  json.title         @post.title
  json.body          @post.body
  json.ip            @post.ip
end

json.user do
  json.id         @user.id
  json.login      @user.login
end
