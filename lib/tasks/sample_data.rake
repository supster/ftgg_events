require 'eventbrite-client'

namespace :db do
 desc "Create events from Eventbrite" 

 task populate: :environment do
 
    eb_auth_tokens = {  app_key: 'PQ2YC4P46HW7Z2XNBU',
                        user_key: '12862222916999175723'}
    
    eb_client = EventbriteClient.new(eb_auth_tokens)

    response = eb_client.event_search(keywords: "nonprofit", city: "New York", max: "50")

    events_json = response.parsed_response["events"]
   
    $i = 1
    while $i > 0 and $i < events_json.count do
      event = Event.new
      event.name = events_json[$i]["event"]["title"]
      event.description = events_json[$i]["event"]["description"]
      event.start_date_time = events_json[$i]["event"]["start_date"]
      event.end_date_time = events_json[$i]["event"]["end_date"]
      event.url = events_json[$i]["event"]["url"]
      event.location = events_json[$i]["event"]["venue"]["name"]   
      event.address = events_json[$i]["event"]["venue"]["address"] + events_json[$i]["event"]["venue"]["address_2"] + ', ' + events_json[$i]["event"]["venue"]["city"] + ', ' + events_json[$i]["event"]["venue"]["region"] + ' ' + events_json[$i]["event"]["venue"]["postal_code"]
   
      #puts events_json[$i]["event"]["venue"]["address"]
      #puts events_json[$i]["event"]["venue"]["address_2"]
      #puts events_json[$i]["event"]["venue"]["city"]
      #puts events_json[$i]["event"]["venue"]["region"]
      #puts events_json[$i]["event"]["venue"]["postal_code"]
      event.cost = events_json[$i]["event"]["tickets"][0]["ticket"]["price"]
      $i = $i + 1

      if event.valid?
        event.save
      else
        event.errors.inspect
      end
    end
 end
 

 #populate vendors
 def make_GED(filename, institution_type)
    csv_contents = CSV.parse(File.read(filename), {:converters => :all, headers: true} ) do |row|
    institution = Institution.new(name: row[0], address: row[1], city: row[2], 
                         state_abbr: "NY", phone: row[3], description: "Anyone interested in taking the official G.E.D. Test must demonstrate readiness by bringing a referral from an Adult Education Program.",
                         url: row[5], institution_type: institution_type)
    if institution.valid?
      institution.save
    else
      institution.errors.inspect
    end
  end
 end

 def make_Work(filename, institution_type)
    csv_contents = CSV.parse(File.read(filename), {:converters => :all, headers: true} ) do |row|
    institution = Institution.new(name: row[0], address: row[1], city: row[2], zip_code: row[3],
                         state_abbr: "NY", phone: row[4], url: row[5], institution_type: institution_type,
                         description: "Workforce and career training program")
    if institution.valid?
      institution.save
    else
      institution.errors.inspect
    end
  end
 end
end