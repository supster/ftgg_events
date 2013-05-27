require 'eventbrite-client'

class EbsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update, :index]
  def index
  	@ebs = EventBrite.where("archieve = false or archieve is null").order("start_date_time").paginate(page: params[:page], per_page: 30)
  end

  def edit
  end

  def create
  	if params[:button] == "retrieve"
  	  eb_auth_tokens = {  app_key: 'PQ2YC4P46HW7Z2XNBU',
  		                    user_key: '12862222916999175723'}
  		
	  eb_client = EventbriteClient.new(eb_auth_tokens)

	  max_eb_id = EventBrite.maximum("eb_id")

	  response = eb_client.event_search(keywords: "nonprofit", since_id: max_eb_id, city: "New York", max: "50")

	  events_json = response.parsed_response["events"]

	  $i = 1
	  while $i > 0 and $i < events_json.count do
		event = EventBrite.new
		event.eb_id = events_json[$i]["event"]["id"] 
		event.name = events_json[$i]["event"]["title"]
		event.description = events_json[$i]["event"]["description"]
		event.start_date_time = events_json[$i]["event"]["start_date"]
		event.end_date_time = events_json[$i]["event"]["end_date"]
		event.url = events_json[$i]["event"]["url"]
		event.location = events_json[$i]["event"]["venue"]["name"]   
		event.address = events_json[$i]["event"]["venue"]["address"] + events_json[$i]["event"]["venue"]["address_2"] + ', ' + events_json[$i]["event"]["venue"]["city"] + ', ' + events_json[$i]["event"]["venue"]["region"] + ' ' + events_json[$i]["event"]["venue"]["postal_code"]

		event.cost = events_json[$i]["event"]["tickets"][0]["ticket"]["price"]
		$i = $i + 1

		if event.valid?
		  event.save
		else
		  event.errors.inspect
	  	end
	  end
	elsif params[:button] = "show"
		# copy records from EventBrite to Event table
		s_where = "id in (?)", params[:eb_ids]
		@ebs = EventBrite.where(s_where).select("name, description, start_date_time,
															 end_date_time, url, location, address, cost")
		Event.create(@ebs.map(&:attributes))
		#EventBrite.update(params[:eb_ids], {display: true, archieve: true})
		EventBrite.update_all("display = true, archieve = true", s_where)
  	end 
 
  	redirect_to ebs_path
  	#render "index"
  end

  def update
  end
end
