require 'eventbrite-client'

module EventsHelper
  def populate_eventbrite
  	eb_auth_tokens = {  app_key: 'PQ2YC4P46HW7Z2XNBU',
                        user_key: '12862222916999175723'}
    
    eb_client = EventbriteClient.new(eb_auth_tokens)

    response = eb_client.event_search(keywords: "nonprofit", city: "New York", max: "50")

    events_json = response.parsed_response["events"]
    puts response.parsed_response
    puts events_json.count
    #puts events_json[1]["event"]["title"]
    #puts events_json[1]["event"]["link_color"]
    
    $i = 1
    while $i > 0 and $i < events_json.count do
    	puts $i.to_s + " " + events_json[$i]["event"]["title"]
    	#puts events_json[$i]["event"]["description"]
    	puts events_json[$i]["event"]["start_date"]
    	puts events_json[$i]["event"]["end_date"]
    	puts events_json[$i]["event"]["url"]
		puts events_json[$i]["event"]["venue"]["name"]    	
		puts events_json[$i]["event"]["venue"]["address"] + events_json[$i]["event"]["venue"]["address_2"] + ', ' + events_json[$i]["event"]["venue"]["city"] + ', ' + events_json[$i]["event"]["venue"]["region"] + ' ' + events_json[$i]["event"]["venue"]["postal_code"]
		puts events_json[$i]["event"]["tickets"][0]["ticket"]["price"]
    	$i = $i + 1
    end

    #events_json.each do |event|
    #	puts event["title"]
    #	puts event["event"]["id"]
    #end 
    #puts response.parsed_response



  end
end
