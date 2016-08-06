class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title,  use: [:slugged]
  validates :title, :user_id, presence: true

  belongs_to :author,
  foreign_key: :user_id,
  class_name: :User

  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub

  has_many :comments

  has_many :votes, as: :votable

  def comments_by_parent_id
    result = Hash.new { [] }
    comments.includes(:author).each do |comment|
      result[comment.parent_comment_id] += [comment]
    end
    result
  end

  def score
    Vote.where(votable_id: id, votable_type: "Post").sum(:value)
  end

  # def self.find
  #   self.friendly.find
  # end

end
