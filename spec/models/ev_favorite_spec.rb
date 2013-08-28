require 'spec_helper'

describe EvFavorite do
  describe "User favorite an event" do
    before {
      @user = User.new(name: "test")
      @event = Event.new(name: "test event")
    }
  end
end
