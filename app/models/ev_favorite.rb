class EvFavorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  attr_accessible :event_id
  # attr_accessible :title, :body

  validates :user_id,  presence: true
  validates :event_id, presence: true
end
