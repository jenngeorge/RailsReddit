class Post < ActiveRecord::Base
  validates :title, :user_id, :sub_id, presence: true

  belongs_to :author,
  foreign_key: :user_id,
  class_name: :User

  belongs_to :sub 

end
