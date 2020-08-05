class Idea < ApplicationRecord
  belongs_to :user
  has_many(:reviews, dependent: :destroy)


  has_many :likes
  has_many :likers, through: :likes, source: :user

  validates(:title, presence: true, uniqueness: true)
  validates(
      :body,
      presence: { message:"You have to provide body"},
      length: { minimum: 10 }
      )

  scope(:recent, -> { order(created_at: :DESC).limit(10) })

  def self.all_with_user_counts
      self.left_outer_joins(:reviews)
          .select("ideas.*", "COUNT(reviews.*) AS members")
          .group("ideas.id")
  end
end
