class CommentsController < ApplicationController
  before_action :require_sign_in

  def create
    @post = Post.find(params[:post_id])
    @user = current_user

    @comment = @post.comments.new(comment_params)
    @comment.user = @user

    @comment.save
    redirect_to post_path(@post, anchor: 'comment-form')
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
