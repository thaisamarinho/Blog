class Post < ApplicationRecord

  belongs_to :user

  has_many :comments, lambda {order(created_at: :desc)}, dependent: :destroy

  validates :title, presence: true, length: { minimum: 7 }
  validates :body, presence: true

  belongs_to :category

  has_many :favourites, dependent: :destroy
  has_many :favouriters, through: :favourites, source: :user


  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :stars, dependent: :destroy
  has_many :star_raters, through: :stars, source: :user

  


  def body_snippet
    if self.body.length > 100
      return self.body[0...100] + "..."
    else
      return self.body
    end
  end

end
