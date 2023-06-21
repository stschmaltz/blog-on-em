class PostsController < ApplicationController
  before_action :require_sign_in, except: %i[index show]
  before_action :require_admin, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @unpublished_posts = Post.unpublished
    @tags = Tag.all

    tag = params[:filter] && Tag.find_by(name: params[:filter])

    @posts = tag ? Post.with_tag(tag.id).decending : Post.published
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post updated successfully'
    else
      render :edit
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_path(@post), notice: 'Post created successfully'
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private # Everything below this line is private

  def post_params
    params.require(:post).permit(:title, :body, :published_at, tag_ids: [])
  end

  def find_post_by_id
    Post.find_by(id: params[:id])
  end

  def set_post
    @post = Post.find_by!(slug: params[:id])
  end
end
