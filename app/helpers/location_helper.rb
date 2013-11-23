class LocationHelper
  MARGIN = 0.003

  def self.adjust(annotations)
  	sorted_lat = annotations.sort_by { |a| a.coordinate.latitude }
  	sorted_lng = annotations.sort_by { |a| a.coordinate.longitude }
    
    biggest_lat, lowest_lat = sorted_lat.last.coordinate.latitude, sorted_lat.first.coordinate.latitude
    biggest_lng, lowest_lng = sorted_lng.last.coordinate.longitude, sorted_lng.first.coordinate.longitude

    [biggest_lat + MARGIN, biggest_lng + MARGIN, lowest_lat - MARGIN, lowest_lng - MARGIN]
  end
end