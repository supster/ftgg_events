class EvFavoritesController < ApplicationController

  respond_to :html, :js

	def create
		@event = Event.find(params[:event_id])
	  	current_user.ev_favorite!(@event.id)
	   respond_with @event
	end   

   def destroy
   	@event = Event.find(params[:event_id])
      current_user.ev_unfavorite!(params[:event_id])
      respond_with @event
   end

   def index
   	@ev_favorites = current_user.ev_favorites.all
   end
end
