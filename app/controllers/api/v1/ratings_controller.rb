module Api
  module V1
    class RatingsController < ApplicationController
      before_action :fetch_rating, only: :update
      def create
        result = RatingService.call(rating_params[:user_id], rating_params[:post_id], rating_params[:value])

        if result[:errors]
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        else
          render json: { average_rating: result[:average_rating] }, status: :created
        end
      end

      def update
        if @rating.update(rating_params)
          render json: { rating: @rating }
        else
          render json: { errors: @rating.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def rating_params
        params.require(:rating).permit(:post_id, :user_id, :value)
      end

      def fetch_rating
        @rating = Rating.find(params[:id])
      end
    end
  end
end
