class FormHelper
   include BW::KVO

  def initialize
  	@cities = { :warszawa => 
                  { "Autobus" => ['116', '222', '519'], 
                    "Autobus nocny" => ['N1', 'N2'],
                    "Tramwaj" => ['9', '22', '45'],
                    "SKM" => ['S1', 'S2', 'S3'],
                    "WKD" => ['Wkd1', 'Wkd2']
                  } 
             }

  end

  def report_form
  	@form = Formotion::Form.new({
      sections: [{
          title: "Środek transportu",
          rows: [{
            type: :picker,
            key: :pick,
            items: @cities[:warszawa].keys,
            value: @cities[:warszawa].keys[0],
            input_accessory: :done
          }]
      }, {
        title: "Numer",
        rows: [{
          type: :picker,
          key: :pick,
          items: @cities[:warszawa].first[1],
          value: @cities[:warszawa].first[1][0],
          input_accessory: :done
        }]
      }, {
        rows: [{
          title: "Zgłoś",
          type: :submit
        }]
      }]
    })

    @transport_row = @form.sections[0].rows[0]
    @numbers_row = @form.sections[1].rows[0]

    puts "-- Numbers: #{@numbers_row.object.picker}"

    observe(@transport_row, :value) do |old_value, new_value|
      if old_value == new_value
        @numbers_row.items = @cities[:warszawa][new_value]
        @numbers_row.value = @cities[:warszawa][new_value][0]

        # puts "New items: #{cities[:warszawa][new_value]}"
        # puts "New value: #{cities[:warszawa][new_value][0]}"
        @numbers_row.object.picker.reloadAllComponents
      end
    end

    @form
  end

  def on_submit(map_controller, transport_row, numbers_row)
  	@form.on_submit do |form|
      map_controller.navigationController.popViewControllerAnimated(true)

      puts "Transport type #{@transport_row.value}"

      event = Event.new(:lat => 52.2375335693359, :lng => 21.0070571899414, 
                        :transport_type => @transport_row.value.json_name, :line_number => @numbers_row.value)

      Event.save_event(event) do
        map_controller.refresh_map
      end
    end
  end

  def new_items(new_value)
    @cities[:warszawa][new_value]
  end

  def new_value(new_value)
    @cities[:warszawa][new_value][0]
  end
end