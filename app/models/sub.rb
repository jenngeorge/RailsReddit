class Sub < ActiveRecord::Base
  validates :user_id, :title, presence: true

  belongs_to :moderator
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User,
    dependent: :destroy

end
