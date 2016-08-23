class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  #mount_uploader :avatar, AvatarUploader

  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def friend
    followers && followed_users
  end

  def self.find_for_facebook_oauth(auth, sign_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    user = User.new(
      name: auth.info.name,
      nick_name: auth.info.name,
      email: auth.info.email || User.create_email,
      image_url: auth.info.image,
      provider: auth.provider,
      uid: auth.uid,
      password: Devise.friendly_token[0,20]
    ) unless user

    user.skip_confirmation!
    user.save
    user
  end

  def self.find_for_twitter_oauth(auth, sign_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    user = User.new(
      name: auth.info.name,
      nick_name: auth.info.nickname,
      email: User.create_email,
      image_url: auth.extra.profile_image_url,
      provider: auth.provider,
      uid: auth.uid,
      password: Devise.friendly_token[0,20]
    ) unless user

    user.skip_confirmation!
    user.save
    user
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def self.create_email
    SecureRandom.uuid + '@example.com'
  end



end
