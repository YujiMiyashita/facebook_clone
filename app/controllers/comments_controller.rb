class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :cannot_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.topic_id = params[:topic_id]
    @comments = @comment.topic.comments
    if @comment.save
      respond_to do |format|
        format.js { render :create }
      end
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to topic_path(@comment.topic)
    else
      render :edit
    end
  end

  def destroy
    @comments = @comment.topic.comments
    @comment.destroy
    respond_to do |format|
      format.js { render :destroy }
    end
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def cannot_comment
    if @comment.user != current_user
      redirect_to topic_path(@comment.topic), notice: '投稿者が自分ではないため、実行できませんでした。'
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
