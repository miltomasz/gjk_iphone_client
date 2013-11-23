module Formotion
  module RowType
    class PickerViewWithNavigationRow < Base
      def build_cell(cell)

      	@table_view = UITableView.alloc.initWithFrame([[0.0, 0.0], [320.0, 44.0]],
                                                  style: UITableViewStyleGrouped)
        @table_view.dataSource = self
        @table_view.delegate = self

        cell.addSubview(@table_view)   # !?

		@modal_view = UIControl.alloc.initWithFrame([[0, 0], [320, 460]])  # [[0, 0, 320, 460]], if you are the "show me the numbers" type
	    @modal_view.backgroundColor = :black.uicolor(0.5)  # black, with alpha of 0.5
	    @modal_view.alpha = 0.0  # hide the view

	    cell.addSubview(@modal_view)

	    @keyboard_view = UIView.alloc.initWithFrame([[0, 460], [320, 260]])  # y: 460, so offscreen, at the bottom.
	    cell.addSubview(@keyboard_view)

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
	    @keyboard_view.addSubview(nav_bar)

	    @picker_delegate = AwesomePickerDelegate.new
	    @picker_view = UIPickerView.alloc.initWithFrame([[0, 44], [320, 216]])
	    @picker_view.showsSelectionIndicator = true
	    @picker_view.delegate = @picker_view.dataSource = @picker_delegate
	    @picker_view.selectRow(1, inComponent:0, animated:false)
	    @keyboard_view.addSubview(@picker_view)
	    nil
      end

      def tableView(table_view, cellForRowAtIndexPath:index_path)
	    cell = table_view.dequeueReusableCellWithIdentifier('Cell')

	    unless cell
	      cell = UITableViewCell.alloc.initWithStyle(:value1.uitablecellstyle,   # !?
	                                                  reuseIdentifier:'Cell')
	      
	    end

	    if index_path.section == 0
	      cell.textLabel.text = "gggg"
	    else
	      cell.textLabel.text = "Hej"
	    end

	    return cell
	  end

	  # def tableView(table_view, titleForHeaderInSection:section)
	  #   if section == 0 
	  #     "Środek transportu:" 
	  #   else 
	  #     "Numer:" 
	  #   end
	  # end

	  def tableView(table_view, numberOfSectionsInTableView:section)
	    1
	  end

	  def tableView(table_view, numberOfRowsInSection:section)
	    1
	  end

	  def tableView(table_view, didSelectRowAtIndexPath:index_path)
	    table_view.deselectRowAtIndexPath(index_path, animated:true)

	    @modal_view.fade_in
	    @keyboard_view.slide :up
	  end
    end
  end
end