class Post < ActiveRecord::Base
  validates :title, :user_id, presence: true

  belongs_to :author,
  foreign_key: :user_id,
  class_name: :User

  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub

  has_many :comments 
end
