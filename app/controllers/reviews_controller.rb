class ReviewsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    def create
    byebug
        @idea = Idea.find params[:idea_id]
        @review = Review.new params.require(:review).permit(:body)
        @review.user = current_user
        @review.idea = @idea
        if @review.save
            redirect_to idea_path(@idea)
        else
            redirect_to idea_path(@idea)
        end 
    end
    def destroy
        
        @review = Review.find params[:id]
        if can?(:crud, @review)
        @review.destroy
        redirect_to idea_path(@review.idea)
        else
            flash[:alert] = "not aurtorize "
        end
    end
end
