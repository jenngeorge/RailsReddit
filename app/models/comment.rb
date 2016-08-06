class Comment < ActiveRecord::Base
  validates :user_id, :post_id, :content, presence: true

  belongs_to :author,
  foreign_key: :user_id,
  class_name: :User

  belongs_to :post

  has_many :votes, as: :votable

  belongs_to :parent_comment,
    foreign_key: :parent_comment_id,
    class_name: :Comment

  has_many :child_comments,
    foreign_key: :parent_comment_id,
    class_name: :Comment

  def self.scores
    Vote
      .where(votable_type: "Comment")
      .group(:votable_id)
      .sum(:value)
  end
end
