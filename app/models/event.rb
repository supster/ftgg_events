class Event < ActiveRecord::Base
  attr_accessible 	:name, :description, :address, :location, :cost, 
  					:end_date_time, :start_date_time, :time_zone, :url, :benefits
            
  validate 	:start_date_time_cannot_be_in_the_past
  validate	:end_date_time_cannot_be_in_the_past
  validate	:start_date_time_cannot_be_after_end_date_time

  validates :name, presence: true, length: { maximum: 255 }
  validates :end_date_time, presence: true
  validates :start_date_time, presence: true
  validates :address, presence: true, length: { maximum: 255 }
  validates :cost, numericality: { greater_than_or_equal_to: 0 }

  def start_date_time_cannot_be_in_the_past
    if !start_date_time.blank? and start_date_time < Time.now
      errors.add(:start_date_time, "can't be in the past")
    end
  end

  def end_date_time_cannot_be_in_the_past
    if !end_date_time.blank? and end_date_time < Time.now
      errors.add(:end_date_time, "can't be in the past")
    end    
  end

  def start_date_time_cannot_be_after_end_date_time
    if !start_date_time.blank? and !end_date_time.blank? and start_date_time.to_time > end_date_time.to_time
      errors.add(:start_date_time, "can't be later than end date time")
    end
  end

=begin
  def start_date
    start_date_time.strftime("%m/%d/%Y")
  end

  def start_date=(start_date)
    @start_date = Date.parse(start_date)
  rescue ArgumentError
    @start_date_time_invalid = true
  end

  def validate
    errors.add(:start_date_time, "is invalid") if @start_date_time_invalid
  end
=end

end
