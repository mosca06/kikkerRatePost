describe 'GET /api/v1/posts/top' do
  before do
    users = create_list(:user, 3)

    @post1 = create(:post, user: users[0])
    @post2 = create(:post, user: users[1])
    @post3 = create(:post, user: users[2])

    create(:rating, user: users[0], post: @post1, value: 5)
    create(:rating, user: users[1], post: @post1, value: 4)

    create(:rating, user: users[0], post: @post2, value: 2)
    create(:rating, user: users[1], post: @post2, value: 3)

    create(:rating, user: users[2], post: @post3, value: 1)
  end

  it 'retorna os posts ordenados por média de avaliação' do
    get '/api/v1/posts/top.json', params: { limit: 2 }

    expect(response).to have_http_status(:ok)

    posts = response.parsed_body
    expect(posts.length).to eq(2)

    expect(posts[0]['id']).to eq(@post1.id)
    expect(posts[1]['id']).to eq(@post2.id)
  end
end
