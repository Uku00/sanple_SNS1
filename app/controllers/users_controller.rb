class UsersController < ApplicationController
 
  before_action :authenticate_user!, only: [:mypage, :edit, :update]
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def mypage
    @user = current_user
    @posts = current_user.posts.includes(:photos)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
     redirect_to mypage_path, notice: "プロフィールを更新しました"
    else
     render :edit
    end
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    redirect_to root_path, alert: "他人のプロフィールは編集できません" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:nickname, :introduction, :avatar_image)
  end
end
