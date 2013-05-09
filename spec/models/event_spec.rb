require 'spec_helper'

describe Event do
	before do 
		@event = Event.new(name: "Non-profit meet up", description: "test",
							  start_date_time: Time.now + 1.hour, end_date_time: Time.now + 2.hour,
							  location: "NYU", address: "123 8 street, New York, NY", cost: 0)
	end

	subject { @event}

	it { should respond_to(:name) }
	it { should respond_to(:description) }
	it { should respond_to(:start_date_time) }
	it { should respond_to(:end_date_time) }
	it { should respond_to(:location) }
	it { should respond_to(:address) }
	it { should respond_to(:cost) }

	it { should be_valid }

	describe "when name is not present" do
		before { @event.name = ""}
		it { should_not be_valid }
	end

	describe "when name is longer than 255" do
		before { @event.name = "a" * 256 }
		it { should_not be_valid }
	end

	describe "when start_date_time is nil" do
		before { @event.start_date_time = nil }
		it { should_not be_valid }
	end

	describe "when end_date_time is nil" do
		before { @event.end_date_time = nil }
		it { should_not be_valid }
	end

	describe "when address is not present" do
		before { @event.address = "" }
		it { should_not be_valid }
	end

	describe "when cost is less than zero" do
		before { @event.cost = -10 }
		it { should_not be_valid }
	end

	describe "when start date and end date are invalid" do
		describe "when start date is in the past" do
			before { @event.start_date_time = Time.now - 1.day }
			it { should_not	be_valid }
		end

		describe "when end date is in the past" do
			before { @event.end_date_time = Time.now - 1.day }
			it { should_not	be_valid }
		end

		describe "when start date is after end date" do
			before { 
				@event.start_date_time = Time.now + 2.hour
				@event.end_date_time = Time.now + 1.hour
			}
			it { should_not	be_valid }
		end
	end

	describe "when start date and end date are valid" do
		describe "when start date is before end date in the future" do
			before { 
				@event.start_date_time = Time.now + 1.hour 
				@event.end_date_time = Time.now + 2.hour 
			}
			it { should	be_valid }
		end
	end

		
end
