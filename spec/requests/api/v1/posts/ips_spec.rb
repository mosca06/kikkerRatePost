require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  before(:each) do
    @user1 = User.create!(login: 'user1')
    @user2 = User.create!(login: 'user2')
    @user3 = User.create!(login: 'user3')

    Post.create!(user: @user1, title: 'Post 1', body: 'Body 1', ip: '192.168.1.1')
    Post.create!(user: @user2, title: 'Post 2', body: 'Body 2', ip: '192.168.1.1')
    Post.create!(user: @user3, title: 'Post 3', body: 'Body 3', ip: '192.168.1.2')
  end

  describe 'GET /api/v1/posts/ips' do
    it 'retorna um array de IPs com os logins dos autores' do
      get '/api/v1/posts/ips'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to contain_exactly(
          { "ip"=>"192.168.1.2", "logins"=>[ "user3" ] },
          { "ip"=>"192.168.1.1", "logins"=>[ "user1", "user2" ] }
      )
    end
  end
end
