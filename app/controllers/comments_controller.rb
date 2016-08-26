class CommentsController < ApplicationController
  before_action :authenticate_user!

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
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to topic_path(@comment.topic)
    else
      render :edit
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comments = @comment.topic.comments
    @comment.destroy
    respond_to do |format|
      format.js { render :destroy }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
