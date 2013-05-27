class EventsController < ApplicationController
  before_filter :fix_date_params, :only => [:create, :update]
  before_filter :signed_in_user, only: [:new, :create, :edit, :update]

  def index
  	@events = Event.where("start_date_time >= '#{Time.now}'").order("start_date_time").paginate(page: params[:page], per_page: 30)
  end

  def search
  	
  end

  def new
  	@event = Event.new
  end

  def create
  	@event = Event.new(params[:event])
    if @event.save
      flash[:success] = "Event saved!"
      redirect_to @event
    else
      render "new"      
    end
  end

  def show
    @event = Event.find(params[:id])
  end

private
  def fix_date_params
    if params[:event][:start_date_time] != ""
      start_date = Date.strptime(params[:event].delete(:start_date_time), "%m/%d/%Y") 
      
      params[:event].merge!({
        'start_date_time(1i)' => start_date.year.to_s,
        'start_date_time(2i)' => start_date.month.to_s,
        'start_date_time(3i)' => start_date.day.to_s
      })
    else
      params[:event].merge!({
        'start_date_time(1i)' => "",
        'start_date_time(2i)' => "",
        'start_date_time(3i)' => ""
      })      
    end

    if params[:event][:end_date_time] != ""
      end_date = Date.strptime(params[:event].delete(:end_date_time), "%m/%d/%Y")

      params[:event].merge!({
        'end_date_time(1i)' => end_date.year.to_s,
        'end_date_time(2i)' => end_date.month.to_s,
        'end_date_time(3i)' => end_date.day.to_s
      })
    else
      params[:event].merge!({
        'end_date_time(1i)' => "",
        'end_date_time(2i)' => "",
        'end_date_time(3i)' => ""
      })      
    end 
  end
end
