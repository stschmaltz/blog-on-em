class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = find_post_by_id
  end

  def edit
    @post = find_post_by_id
  end

  def update
    post = find_post_by_id

    post.update(post_params)

    redirect_to post_path(post)
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.create(post_params)

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
