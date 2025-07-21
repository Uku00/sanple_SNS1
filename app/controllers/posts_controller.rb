class PostsController < ApplicationController
  
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:[:new, :create]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.includes(:user, :likes).order(created_at: :desc)
  end

  def new
    @post = Post.new
    3.times { @post.photos.build } 
  end
 
  def create
  @post = current_user.posts.build(post_params) 
  if @post.save
    save_tags(@post, params[:post][:tag_names]) 
    redirect_to posts_path, notice: "投稿が作成されました"
  else
    render :new
  end
end
  
  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
    if @post.update(post_params)
      @post.post_tags.destroy_all
      save_tags(@post, params[:post][:tag_names])
      redirect_to post_path(@post), notice: "投稿を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  
  private

  def save_tags(post, tag_names)
    return if tag_names.blank? 

    tag_names.split(/[,\s]+/).uniq.each do |name|
     tag = Tag.find_or_create_by(name: name)
     post.tags << tag unless post.tags.include?(tag)
    end
  end

 def set_post
   @post = Post.find(params[:id])
 end

 def ensure_correct_user
   redirect_to posts_path, alert: "他人の投稿は編集できません" unless @post.user == current_user
 end

def post_params
  params.require(:post).permit(
    :title,
    :body,
    photos_attributes: [:image, :description, :text_color, :text_align, :image_position, :_destroy]
  )
end

end