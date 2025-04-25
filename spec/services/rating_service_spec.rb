RSpec.describe RatingService do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  it "cria um rating com sucesso" do
    result = RatingService.call(user.id, post.id, 4)

    expect(result).to include(:average_rating)
    expect(result[:average_rating]).to eq(4.0)
  end

  it "retorna erro se o usuário já avaliou" do
    create(:rating, user: user, post: post, value: 4)

    result = RatingService.call(user.id, post.id, 5)

    expect(result[:errors]).to include("User already rated this Post.")
  end
end
