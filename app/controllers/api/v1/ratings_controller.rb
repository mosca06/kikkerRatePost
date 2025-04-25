module Api
  module V1
    class RatingsController < ApplicationController
      def create
        result = RatingService.call(rating_params[:user_id], rating_params[:post_id], rating_params[:value])

        if result[:errors]
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        else
          render json: { average_rating: result[:average_rating] }, status: :created
        end
      end

      private

      def rating_params
        params.require(:rating).permit(:post_id, :user_id, :value)
      end
    end
  end
end
