class IdeasController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    def index
        @idea = Idea.all
    end
    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new params.require(:idea).permit(:title, :description)
        @idea.user = current_user
        if @idea.save
            flash[:notice] = "Idea created successfully"
            redirect_to ideas_path
        else render :new
        end
    end

    def show
        @idea = Idea.find params[:id]
        @review = Review.new
        @reviews = @idea.reviews


    end

    def edit
        @idea = Idea.find params[:id]

    end

    def update
        if @idea.update params.require(:idea).permit(:title, :description)
            redirect_to idea_path(@idea)
            else render :edit
        end

    end


    def destroy
        @idea.destroy

        redirect_to ideas_path

    end
    private
    def find_idea
        @idea = Idea.find params[:id]
    end
    def authorize_user!
        redirect_to ideas_path, alert:"Access Denied" unless can?(:crud, Idea)
    end
end
