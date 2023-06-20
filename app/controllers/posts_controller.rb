class PostsController < ApplicationController
  before_action :require_sign_in, except: %i[index show]
  before_action :require_admin, except: %i[index show]

  def index
    @unpublished_posts = Post.unpublished
    @tags = Tag.all

    tag = params[:filter] && Tag.find_by(name: params[:filter])

    @posts = tag ? Post.with_tag(tag.id).decending : Post.published
  end

  def show
    @post = find_post_by_id
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit
    @post = find_post_by_id
  end

  def update
    @post = find_post_by_id

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
    post = find_post_by_id
    post.destroy
    redirect_to posts_path
  end

  private # Everything below this line is private

  def post_params
    params.require(:post).permit(:title, :body, :published_at, tag_ids: [])
  end

  def find_post_by_id
    Post.find_by(id: params[:id])
  end
end
