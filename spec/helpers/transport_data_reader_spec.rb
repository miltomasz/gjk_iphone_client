describe "helper TransportDataReader" do
  before do
  	Dir.chdir(File.expand_path(File.dirname(__FILE__)))
    @file = File.read("../../resources/cities.json")
  end

  it "parses cities.json file" do
    @cities = TransportDataReader.parse(@file)
  	@cities.class.should == Array
  	@cities.size.should == 2
  end

  it "has 'warszawa' as first city" do
    @cities = TransportDataReader.parse(@file)
  	@cities[0].keys.first.should == 'warszawa'
  end

  it "has 'krakow' as second city" do
  	@cities = TransportDataReader.parse(@file)
  	@cities[1].keys.first.should == 'krakow'
  end
end