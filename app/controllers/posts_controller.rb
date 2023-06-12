class PostsController < ApplicationController
  def index
    @published_posts = Post.published
    @unpublished_posts = Post.unpublished
  end

  def show
    @post = find_post_by_id
  end

  def edit
    @post = find_post_by_id
  end

  def update
    post = find_post_by_id
    if post.update(post_params)
      post.tags = params[:post][:tags].split(',')
      post.save
    end
    # TODO: put error handling if update fails here
    redirect_to post_path(post)
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.tags = params[:post][:tags].split(', ')
    post.save
    redirect_to post_path(post)
  end

  def destroy
    post = find_post_by_id
    post.destroy
    redirect_to posts_path
  end

  private # Everything below this line is private

  def post_params
    params.require(:post).permit(:title, :body, :published_at)
  end

  def find_post_by_id
    Post.find_by(id: params[:id])
  end
end
