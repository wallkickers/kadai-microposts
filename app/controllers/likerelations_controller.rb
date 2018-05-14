class LikerelationsController < ApplicationController
  before_action :require_user_logged_in

  def create
    post = Micropost.find(params[:micropost_id])
    current_user.like(post)
    flash[:success] = "postをLikeしました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Micropost.find(params[:micropost_id])
    current_user.unlike(post)
    flash[:success]="postからLikeを外しました"
    redirect_back(fallback_location: root_path)
  end
  
end
