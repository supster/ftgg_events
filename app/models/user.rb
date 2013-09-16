class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  has_many :ev_favorites, dependent: :destroy
  has_secure_password

  before_save { |user| user.email = user.email.downcase }
  before_save :create_remember_token

  validates :first_name, length: { maximum: 30 }
  validates :last_name, length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w\-.\+]+@[a-z\d\-.]+\.+[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }   
  validates :password, presence: true, length: { minimum: 6}
  validates :password_confirmation, presence: true

  def ev_favorite!(event_id)
    self.ev_favorites.create(event_id: event_id)
  end
  
  def ev_favorite?(event_id)
    self.ev_favorites.find_by_event_id(event_id)
  end

  def ev_unfavorite!(event_id)
    self.ev_favorites.find_by_event_id(event_id).destroy
  end

  private 
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64  
  end
end
