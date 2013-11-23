class Event
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter

  attr_writer :title, :subtitle, :coordinate

  columns :lat => :float,
          :lng => :float,
          :transport_type => :string,
          :line_number => :string,
          :date_creation => :string

  def coordinate
    @coordinate ||= CLLocationCoordinate2D.new
    @coordinate.latitude = lat
    @coordinate.longitude = lng
    @coordinate
  end

  def title
  	"#{transport_type.display_name}, linia #{line_number}" 
  end

  def subtitle
    date = DateUtility.get_date(date_creation)
    time = DateUtility.get_time(date_creation)
  	"#{date}, godz. #{time}"
  end
  
  def to_json
    BW::JSON.generate({ transport_type: transport_type, ine_number: line_number, lat: lat, lng: lng })
  end

  def to_hash
    { transport_type: transport_type, line_number: line_number, lat: lat, lng: lng }
  end

  def self.all(lat, lng, &block)
    BW::HTTP.get("http://localhost:3000/events?lat=#{lat}&lng=#{lng}") do |response|
      if response.ok?
        result_data = BW::JSON.parse(response.body.to_str)
        block.call(result_data)
      end
    end
  end

  def self.save_event(event, &block)
    data = { event: event.to_hash }

    BW::HTTP.post("http://localhost:3000/events", { payload: data } ) do |response|
      if response.ok?
        block.call
      end
    end
  end

end