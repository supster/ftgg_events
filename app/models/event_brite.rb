class EventBrite < ActiveRecord::Base
  attr_accessible :address, :cost, :description, :eb_id, 
  				  :end_date_time, :location, :name, :start_date_time, 
  				  :url, :archieve, :display
end
