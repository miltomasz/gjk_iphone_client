Numbers = [ "Autobus",
            "Autobus Nocny",
            "Tramwaj",
            "SKM",
            "WKD" ]

class ReportController < UIViewController

  # def init
  #   super && self.tap {
  #     @numbers = 1
  #   }
  # end
  
  def viewDidLoad
    super
    self.title = "Antykanar"
    @numbers = 0

    @table_view = UITableView.alloc.initWithFrame(self.view.bounds,
            style: UITableViewStyleGrouped)
    @table_view.dataSource = self
    @table_view.delegate = self

    self.view << @table_view   # !?

    @modal_view = UIControl.alloc.initWithFrame(self.view.bounds)  # [[0, 0, 320, 460]], if you are the "show me the numbers" type
    @modal_view.backgroundColor = :black.uicolor(0.5)  # black, with alpha of 0.5
    @modal_view.alpha = 0.0  # hide the view

    self.view << @modal_view

    @keyboard_view = UIView.alloc.initWithFrame([[0, 460], [320, 260]])  # y: 460, so offscreen, at the bottom.
    self.view << @keyboard_view

    nav_bar = UINavigationBar.alloc.initWithFrame([[0, 0], [320, 44]])

    item = UINavigationItem.new
    item.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
                                                              UIBarButtonSystemItemCancel,
                                                              target: self,
                                                              action: :cancel)

    item.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
                                                                UIBarButtonSystemItemDone,
                                                                target: self,
                                                                action: :done)

    nav_bar.items = [item]  # if you want, play with assigning more items.  I dunno what happens!
    @keyboard_view << nav_bar

    @picker_delegate = AwesomePickerDelegate.new
    @picker_view = UIPickerView.alloc.initWithFrame([[0, 44], [320, 216]])
    @picker_view.showsSelectionIndicator = true
    @picker_view.delegate = @picker_view.dataSource = @picker_delegate
    @picker_view.selectRow(@numbers, inComponent:0, animated:false)
    @keyboard_view << @picker_view

    @modal_view.on :touch do
      cancel
    end

    # view = self.view
    # view.backgroundColor = UIColor.whiteColor

    # width = view.frame.size.width

    # @label_transport = build_label_transport(width)
    # view.addSubview(@label_transport)

    # @input_transport = build_input_transport(width)
    # view.addSubview(@input_transport)

    # @label_numbers = build_label_numbers(width)
    # view.addSubview(@label_numbers)

    # @modal_view = UIControl.alloc.initWithFrame(self.view.bounds)  # [[0, 0, 320, 460]], if you are the "show me the numbers" type
    # @modal_view.backgroundColor = UIColor.colorWithWhite(1.0, alpha:0.5) # black, with alpha of 0.5
    # @modal_view.alpha = 0.0  # hide the view
    # view.addSubview(@modal_view)


    # @keyboard_view = UIView.alloc.initWithFrame([[0, 460], [320, 260]])  # y: 460, so offscreen, at the bottom.
    # view.addSubview(@keyboard_view)
    
    # nav_bar = UINavigationBar.alloc.initWithFrame([[0, 0], [320, 44]])

    # item = UINavigationItem.new
    # item.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
    #                                                             UIBarButtonSystemItemCancel,
    #                                                             target: self,
    #                                                             action: :cancel)

    # item.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
    #                                                             UIBarButtonSystemItemDone,
    #                                                             target: self,
    #                                                             action: :done)

    # nav_bar.items = [item]  # if you want, play with assigning more items.  I dunno what happens!
    # @keyboard_view.addSubview(nav_bar)

    # @picker_delegate = AwesomePickerDelegate.new
    # @picker_view = UIPickerView.alloc.initWithFrame([[0, 44], [320, 216]])
    # @picker_view.showsSelectionIndicator = true
    # @picker_view.delegate = @picker_view.dataSource = @picker_delegate
    # @picker_view.selectRow(1, inComponent:0, animated:false)
    # @keyboard_view.addSubview(@picker_view)
  end

  def tableView(table_view, cellForRowAtIndexPath:index_path)
    cell = table_view.dequeueReusableCellWithIdentifier('Cell')

    unless cell
      cell = UITableViewCell.alloc.initWithStyle(:value1.uitablecellstyle,   # !?
                                                  reuseIdentifier:'Cell')
      
    end

    puts "Numbers: #{Numbers[@numbers]}"
    if index_path.section == 0
      cell.textLabel.text = Numbers[@numbers]
    else
      cell.textLabel.text = "Hej"
    end

    return cell
  end

  def tableView(table_view, titleForHeaderInSection:section)
    if section == 0 
      "Środek transportu:" 
    else 
      "Numer:" 
    end
  end

  def tableView(table_view, numberOfSectionsInTableView:section)
    2
  end

  def tableView(table_view, numberOfRowsInSection:section)
    1
  end

  def tableView(table_view, didSelectRowAtIndexPath:index_path)
    table_view.deselectRowAtIndexPath(index_path, animated:true)

    @modal_view.fade_in
    @keyboard_view.slide :up
  end

  def done
    @numbers = @picker_view.selectedRowInComponent(0)
    @table_view.reloadData
    cancel
  end

  def cancel
    @modal_view.fade_out
    @keyboard_view.slide :down
  end


  def build_label_transport(width)
    label_transport = UILabel.alloc.initWithFrame([[10, 10], [width - 6, 45]])
    label_transport.text = "Środek transportu:"
    label_transport.sizeToFit
    label_transport
  end

  def build_input_transport(width)
    input_field = UITextField.alloc.initWithFrame([[10, 50], [width - 6, 50]])
    input_field.textColor = UIColor.blackColor
    input_field.backgroundColor = UIColor.whiteColor
    input_field.setBorderStyle(UITextBorderStyleRoundedRect)
    input_field.font = UIFont.fontWithName('Arial Rounded MT Bold', size:30)
    input_field
  end

  def build_label_numbers(width)
    label_numbers = UILabel.alloc.initWithFrame([[10, 100], [width - 6, 100]])
    label_numbers.text = "Numer:"
    label_numbers.sizeToFit
    label_numbers
  end
end