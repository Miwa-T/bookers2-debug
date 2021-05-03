class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_many :follower_relationships, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  has_many :followed_relationships, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
  has_many :followed_users, through: :followed_relationships, source: :followed
  
  def followed?(other_user)
    followed_relationships.find_by(follower_id: other_user.id)
  end
  
  def follow!(other_user)
    followed_relationships.create!(follower_id: other_user.id)
  end
  
  def unfollow!(other_user)
    followed_relationships.find_by(follower_id: other_user.id).destroy
  end
    
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 0, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
