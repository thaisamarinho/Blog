class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 7 }
  validates :body, presence: true
  belongs_to :category
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :comments, lambda {order(created_at: :desc)}, dependent: :destroy

  def like_for(user)
    likes.find_by(user: user)
  end


  def body_snippet
    if self.body.length > 100
      return self.body[0...100] + "..."
    else
      return self.body
    end
  end

  def user_full_name
    if user
      user.full_name
    else
      'Annonimous'
    end
  end

end
