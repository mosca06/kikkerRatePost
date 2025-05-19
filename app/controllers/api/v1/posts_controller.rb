module Api
  module V1
    class PostsController < ApplicationController
      def create
        @user = User.find_or_create_by(user_params)
        @post = @user.posts.new(post_params.slice(:title, :body, :ip))

        return render :create, status: :created if @post.save

        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end

      def top
        limit = params[:limit].to_i <= 0 ? 10 : params[:limit].to_i

        @posts = Post.select('posts.id, posts.title, posts.body, AVG(ratings.value) AS average_rating')
                     .joins(:ratings)
                     .group('posts.id')
                     .order('average_rating DESC')
                     .limit(limit)

        render :top, status: :ok
      end

      def ips
        @ips = Post.select('posts.ip, users.login')
                   .joins(:user)
                   .group('posts.ip, users.login')

        render :ips
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
