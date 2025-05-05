require 'rails_helper'

RSpec.describe 'Ratings API - Create', type: :request do
  describe 'POST /api/v1/ratings' do
    let(:user) { create(:user) }
    let(:post_record) { create(:post, user: user) }

    context 'with valid params' do
      it 'creates a rating and returns average_rating' do
        post '/api/v1/ratings', params: { rating: { user_id: user.id, post_id: post_record.id, value: 5 } }

        expect(response).to have_http_status(:created)
        json_response = response.parsed_body
        expect(json_response).to have_key('average_rating')
      end
    end

    context 'with invalid params' do
      it 'returns errors' do
        post '/api/v1/ratings', params: { rating: { user_id: nil, post_id: post_record.id, value: 5 } }

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = response.parsed_body
        expect(json_response).to have_key('errors')
      end
    end
  end
end
