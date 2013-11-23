class MapController < UIViewController
  include BW::KVO
  include BW::HTTP

  def viewDidLoad
    super
    self.title = "Antykanar"
    self.navigationController.navigationBar.tintColor = UIColor.yellowColor

    view = self.view
    view.backgroundColor = UIColor.whiteColor

    frame = view.bounds
    width = frame.size.width
    height = frame.size.height

    left_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh, target:self, action:'refresh_map')
    self.navigationItem.leftBarButtonItem = left_button

    @report_button = build_report_button(width)
    view.addSubview(@report_button)

    @form_helper = FormHelper.new
    @form = @form_helper.report_form

    # @transport_row = @form.sections[0].rows[0]
    # @numbers_row = @form.sections[1].rows[0]

    # puts "-- Numbers: #{@numbers_row.object.picker}"

    # observe(@transport_row, :value) do |old_value, new_value|
    #   if old_value == new_value
    #     @numbers_row.items = @form_helper.new_items(new_value)#cities[:warszawa][new_value]
    #     @numbers_row.value = @form_helper.new_value(new_value)#cities[:warszawa][new_value][0]

    #     # puts "New items: #{cities[:warszawa][new_value]}"
    #     # puts "New value: #{cities[:warszawa][new_value][0]}"
    #     @numbers_row.object.picker.reloadAllComponents
    #   end
    # end

    @form_helper.on_submit(self, @transport_row, @numbers_row)

    @map_view = MKMapView.alloc.initWithFrame([[0,48], [width, height]])
    @map_view.delegate = self

    # uncomment when testing on phone
    # @map_view.showsUserLocation = true

    # below should be removed when user location enabled
    @event = Event.create(:lat => 52.2296756, :lng => 21.0122287, :transport_type => 'autobus', :line_number => '519',:date_creation => '2013-05-07T19:32:33+02:00')
    @map_view.addAnnotation(@event)

    
    @location_manager ||= CLLocationManager.alloc.init
    @location_manager.desiredAccuracy = KCLLocationAccuracyNearestTenMeters
    @location_manager.startUpdatingLocation
    @location_manager.delegate = self

    view.addSubview(@map_view)

    @indicator = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhiteLarge)
    @indicator.center = view.center
    @indicator.color = UIColor.blackColor
    @indicator.hidesWhenStopped = true

    view.addSubview(@indicator)
    
    refresh_map
  end

  def coordinate
    @location_manager.location.coordinate
  end

  def remove_annotations
    user_annotation = @event #@map_view.userLocation
    @map_view.removeAnnotations(@map_view.annotations)
    @map_view.addAnnotation(user_annotation)
  end

  def refresh_map
    remove_annotations
    Event.all(52.2296756, 21.0122287) do |events|
      events.each do |e|
        event = Event.new(:lat => e['event']['lat'], :lng => e['event']['lng'], 
                         :transport_type => e['event']['transport_type'], 
                         :line_number => e['event']['line_number'],
                         :date_creation => e['event']['created_at'])
      
        @map_view.addAnnotation(event)
      end

      biggest_lat, biggest_lng, lowest_lat, lowest_lng = LocationHelper.adjust(@map_view.annotations)

      coordinateSpan = MKCoordinateSpanMake(biggest_lat - lowest_lat, biggest_lng - lowest_lng)
      coordinateCenter = CLLocationCoordinate2D.new((biggest_lat + lowest_lat) / 2, (biggest_lng + lowest_lng) / 2)
      
      @map_view.setRegion(MKCoordinateRegionMake(coordinateCenter, coordinateSpan), animated:true)
    end
  end

  def refresh
    p 'refreshing...'
    SystemSounds.play_system_sound('Spell.caf')
  end

  def localize
    @location_manager ||= CLLocationManager.alloc.init
    @location_manager.desiredAccuracy = KCLLocationAccuracyNearestTenMeters
    @location_manager.startUpdatingLocation
    @location_manager.delegate = self
    p "#{@location_manager.location.coordinate.latitude}"
    p "#{@location_manager.location.coordinate.longitude}"
  end

  ViewIdentifier = 'ViewIdentifier'
  def mapView(mapView, viewForAnnotation:event)
    if view = mapView.dequeueReusableAnnotationViewWithIdentifier(ViewIdentifier)
      view.annotation = event
    else
      view = MKPinAnnotationView.alloc.initWithAnnotation(event, reuseIdentifier:ViewIdentifier)
      view.canShowCallout = true
      # view.animatesDrop = true
    end
    file_transport = TransportTypeHelper.to_picture_ext(event.transport_type)
    view.setImage(UIImage.imageNamed("#{file_transport}.png"))

    view
  end

  def report
    @form_controller = Formotion::FormController.alloc.initWithForm(@form)
    @form_controller.title = "Antykanar"
    self.navigationItem.backBarButtonItem = UIBarButtonItem.alloc.initWithTitle("Powrót", style: UIBarButtonItemStyleBordered, target: nil, action: nil)
    self.navigationController.pushViewController(@form_controller, animated: true)
  end

  private

  def indicator
    # @indicator = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
    @indicator = UIActivityIndicatorView.large
    p "Indicator: #{@indicator}"
    # @indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0)
    @indicator.center = self.view.center

    @indicator.hidesWhenStopped = true


    self.view.addSubview(@indicator)
    # @indicator.bringSubviewToFront(self.view)
    # UIApplication.sharedApplication.networkActivityIndicatorVisible = TRUE
    @indicator
  end

  def build_report_button(width)
    report_button = UIButton.buttonWithType(UIButtonTypeCustom)
    report_button.styleId = 'report_button'
    report_button.setTitle("Zgłoś kontrolę", forState:UIControlStateNormal)
    report_button.setTitleColor(UIColor.blackColor, forState:UIControlStateNormal)
    # report_button.backgroundColor = UIColor.colorWithRed(1.0, green:0.5, blue:0.5, alpha:0.0)
    report_button.layer.cornerRadius = 0.0
    report_button.layer.borderWidth = 0.0
    report_button.frame = CGRectMake(0,0, width, 45)
    report_button.addTarget(self, action:'report', forControlEvents:UIControlEventTouchUpInside)
    report_button
  end
end