class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :set_post

  def create
    @user = current_user

    @comment = @post.comments.new(comment_params)
    @comment.user = @user

    @comment.save
    redirect_to post_path(@post, anchor: 'comment-form')
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find_by!(slug: params[:post_id])
  end
end
