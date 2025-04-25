require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  describe "POST /api/v1/posts" do
    let(:user_login) { "mosca06" }
    let(:valid_attributes) do
      {
        user: { login: user_login },
        post: {
          title: "Título do post",
          body: "Corpo do post",
          ip: "123.45.67.89"
        }
      }
    end

    context "com parâmetros válidos" do
      it "cria um novo post e usuário (se necessário)" do
        expect {
          post "/api/v1/posts", params: valid_attributes
        }.to change(Post, :count).by(1)
         .and change(User, :count).by(1)

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)
        expect(json["post"]["title"]).to eq("Título do post")
        expect(json["user"]["login"]).to eq(user_login)
      end

      it "reutiliza um usuário existente" do
        User.create!(login: user_login)

        expect {
          post "/api/v1/posts", params: valid_attributes
        }.to change(Post, :count).by(1)
         .and change(User, :count).by(0)

        expect(response).to have_http_status(:created)
      end
    end

    context "com parâmetros inválidos" do
      it "retorna erros de validação" do
        invalid_attributes = {
          user: { login: "" },
          post: { title: "", body: "", ip: "" }
        }

        post "/api/v1/posts", params: invalid_attributes

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Title can't be blank")
        expect(json["errors"]).to include("Body can't be blank")
        expect(json["errors"]).to include("Ip can't be blank")
      end
    end
  end
end
