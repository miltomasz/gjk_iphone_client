describe "model Event" do
  before do
    @event = Event.new(lat: 52.76575, lng: 52.123412, transport_type: 'autobus', 
    	line_number: '519', date_creation: '2013-09-04T16:33:20+02:00')
  end

  it "has title with autobus and line number information" do
    @event.title.should == "Autobus, linia 519"
  end

  it "has date and hour in subtitle" do
    @event.subtitle.should == "04-09-2013, godz. 16:33"
  end
end