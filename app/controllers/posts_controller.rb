class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    post = Post.find_by(id: params[:id])
    post_params = params.require(:post).permit(:title, :body, :published_at)

    post.update(post_params)

    redirect_to post_path(post)
  end
end
