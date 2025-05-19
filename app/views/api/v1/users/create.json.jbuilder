json.user do
  json.id           @user.id
  json.login        @user.login
  json.created_at   @user.created_at
end
