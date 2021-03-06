class User < ActiveRecord::Base
  attr_reader :password
  before_validation :ensure_session_token

  has_many :votes 

  validates :user_name, :session_token, :password_digest, presence: true
  validates :password, length: { in: 6..20, allow_nil: true }

  has_many :subs,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Sub

  has_many :comments,
    foreign_key: :user_id,
    class_name: :Comment

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(32)
  end

  def reset_session!
    token = generate_session_token
    self.session_token = token
    self.save
    token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    user unless user.nil? || !user.is_password?(password)
  end

end
