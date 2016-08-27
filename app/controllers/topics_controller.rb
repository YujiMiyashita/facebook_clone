class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :cannot_topic, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @topics = friend_topics
    @topic = Topic.new
  end

  def show
    @comments = @topic.comments
    @comment = @topic.comments.build
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topics_path, notice: 'トピックが作成されました！'
    elsif @topic.invalid?
      redirect_to topics_path, notice: 'トピックが作成されませんでした'
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to topics_path, notice: 'トピックが更新されました！'
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, notice: 'トピックが削除されました！'
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def friend_topics
      topics = Topic.all
      friends = current_user.friend
      @friend_topics = []

      topics.each do |topic|
      friends.each do |fri|
        if fri.present?
          @friend_topics << topic if fri.id == topic.user_id || topic.user_id == current_user.id
        else
          @friend_topics << topic if topic.user_id == current_user.id
        end
      end
      end
    end

    def cannot_topic
      if @topic.user != current_user
        redirect_to topics_path, notice: '投稿者が自分ではないため、実行できませんでした。'
      end
    end

    def topic_params
      params.require(:topic).permit(:title, :content, :user_id)
    end
end
