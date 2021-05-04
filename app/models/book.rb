class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

  def self.looks(hows,words)
    if hows == "match"
      @book = Book.where("title LIKE ?", "#{words}")
    elsif hows == "front"
      @book = Book.where("title LIKE ?", "#{words}%")
    elsif hows == "backward"
      @book = Book.where("title LIKE ?", "%#{words}")
    else hows = "piece"
      @book = Book.where("title LIKE ?", "%#{words}%")
    end
  end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
