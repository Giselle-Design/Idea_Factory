class IdeasController < ApplicationController
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorized!, only: [:edit, :update, :destroy]

  def new
    @idea = Idea.new
  end

  def create
    @idea=Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      flash[:notice] = "Idea Was Created Successfully"
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def show
    @review = Review.new
    @reviews = @idea.reviews.order(created_at: :desc)
    @like = @idea.likes.find_by(user: current_user)
  end



  def index
    @ideas = Idea.all.all_with_user_counts.order('updated_at DESC')
  end

  def edit
  end

  def update
    if @idea.update idea_params
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = "Idea Was Deleted!"
    @idea.destroy
    redirect_to ideas_path
  end




  private

  def idea_params
    params.require(:idea).permit(:title, :body)
  end

  def find_idea
      @idea = Idea.find params[:id]
  end

  def authorized!
    if can?(:crud, @idea)
     @idea.destroy
    else
     flash[:notice] = "Not Authorized"
     redirect_to ideas_path
    end
  end

end
