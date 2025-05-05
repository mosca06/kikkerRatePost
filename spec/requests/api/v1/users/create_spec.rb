require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST /api/v1/users' do
    let(:valid_params) { { user: { login: 'new_user' } } }
    let(:invalid_params) { { user: { login: '' } } }

    it 'creates a new user with valid params' do
      post '/api/v1/users', params: valid_params
      expect(response).to have_http_status(:created)
      expect(response.parsed_body['user']['login']).to eq('new_user')
    end

    it 'returns errors with invalid params' do
      post '/api/v1/users', params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['errors']).to include("Login can't be blank")
    end
  end
end
