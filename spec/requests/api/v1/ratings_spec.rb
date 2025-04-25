require 'rails_helper'

RSpec.describe "Api::V1::Ratings", type: :request do
  describe "POST /api/v1/ratings" do
    let!(:user) { create(:user) }
    let!(:post_record) { create(:post, user: user) }

    context "com dados válidos" do
      it "cria a avaliação e retorna a média" do
        post "/api/v1/ratings", params: {
          rating: {
            user_id: user.id,
            post_id: post_record.id,
            value: 5
          }
        }

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to have_key("average_rating")
        expect(JSON.parse(response.body)["average_rating"]).to eq(5.0)
      end
    end

    context "quando o usuário já avaliou o post" do
      before do
        create(:rating, user: user, post: post_record, value: 4)
      end
      it "não permite avaliar novamente" do
        post "/api/v1/ratings", params: {
          rating: {
            user_id: user.id,
            post_id: post_record.id,
            value: 3
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("User already rated this Post.")
      end
    end

    context "com valor fora do permitido" do
      it "retorna erro de validação" do
        post "/api/v1/ratings", params: {
          rating: {
            user_id: user.id,
            post_id: post_record.id,
            value: 10
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("Value must be between 1 and 5.")
      end
    end

    context "com dados incompletos" do
      it "retorna erro de validação" do
        post "/api/v1/ratings", params: {
          rating: {
            user_id: nil,
            post_id: post_record.id,
            value: 3
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("User must exist")
      end
    end
  end
end
