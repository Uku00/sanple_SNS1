class SearchesController < ApplicationController
  def index
    @keyword = params[:keyword]
    if params[:keyword].present?
     @posts = Post.where("body LIKE ?", "%#{params[:keyword]}%")
    else
     @posts = []
    end

    @posts = Post.where("body LIKE ?", "%#{@keyword}%") 
    @tags = Tag.where("name LIKE ?", "%#{@keyword}%")     
    @users = User.where("nickname LIKE ?", "%#{@keyword}%")  
  end
end
