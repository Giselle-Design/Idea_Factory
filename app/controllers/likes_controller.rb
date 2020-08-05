class LikesController < ApplicationController

before_action :authenticate_user!, only: [:create, :destroy]

def create
  idea = Idea.find params[:idea_id]
  like = Like.new(idea: idea, user: current_user)
  if !can?(:like, idea)
      flash[:danger] = "You can like others Idea"
  elsif like.save
      flash[:success] = 'Idea Liked'
  else
      flash[:danger] = like.errors.full_messages.join(', ')
  end
  redirect_to idea_path(idea)
 end

 def destroy

     like = current_user.likes.find params[:id]

     if !can?(:destroy, like)
         flash[:warning] = "You can't destroy a like you don't own"
     elsif like.destroy
         flash[:success] = "Idea Unliked"
     else
         flash[:warning] = "Couldn't Unlike the Idea"
     end

     redirect_to idea_path(like.idea)
 end

end
