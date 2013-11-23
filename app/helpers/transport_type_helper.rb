class String
  def display_name
    name = case self
             when 'autobus'; 'Autobus'
             when 'night_autobus'; 'Autobus nocny'
             when 'tram'; 'Tramwaj'
             when 'skm'; 'SKM'
             when 'wkd'; 'WKD'
             when 'aglo_autobus'; 'Autobus aglomeracyjny'
             else 'Nieznany'
           end
    name
  end
  def json_name
    name = case self
             when 'Autobus'; 'autobus'
             when 'Autobus nocny'; 'night_autobus'
             when 'Tramwaj'; 'tram'
             when 'SKM'; 'skm'
             when 'WKD'; 'wkd'
             when 'Autobus aglomeracyjny'; 'aglo_autobus'
             else 'unspecified'
           end
    name
  end
end

class TransportTypeHelper
  def self.to_picture_ext(transport_type)
  	extetnsion = case transport_type
  	               when 'autobus'; 'bus'
  	               when 'night_autobus'; 'bus'
  	               when 'tram'; 'tram'
  	               when 'skm'; 'train'
  	               when 'wkd'; 'train'
  	               when 'aglo_autobus'; 'bus'
  	               else 'unspecified'
  	             end
    extetnsion
  end

  def self.to_name(transport_type)
  	name = case transport_type
             when 'autobus'; 'Autobus'
             when 'night_autobus'; 'Autobus nocny'
             when 'tram'; 'Tramwaj'
             when 'skm'; 'SKM'
             when 'wkd'; 'WKD'
             when 'aglo_autobus'; 'Autobus aglomeracyjny'
             else 'Nieznany'
           end
    name
  end
end