module Api
  module V1
    class PostsController < ApplicationController
      def create
        user = User.find_or_create_by(user_params)
        post = user.posts.new(title: post_params[:title], body: post_params[:body], ip: post_params[:ip])

        if post.save
          render json: { post: post, user: user }, status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def top
        limit = params[:limit].to_i <= 0 ? 10 : params[:limit].to_i

        posts = Post.select('posts.id, posts.title, posts.body, AVG(ratings.value) AS average_rating')
                    .joins(:ratings)
                    .group('posts.id')
                    .order('average_rating DESC')
                    .limit(limit)

        render json: posts.as_json(only: [:id, :title, :body])
      end

      def ips
        ips = Post.select('posts.ip, users.login')
                  .joins(:user)
                  .group('posts.ip, users.login')

        result = ips.group_by(&:ip).map do |ip, posts|
          {
            ip: ip,
            logins: posts.map(&:login).uniq
          }
        end

        render json: result
      end

      private

      def post_params
        params.require(:post).permit(:title, :body, :ip)
      end

      def user_params
        params.require(:user).permit(:login)
      end
    end
  end
end
