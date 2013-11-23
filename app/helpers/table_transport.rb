class TransportTableFactory
  def initialize(modal_view, keyboard_view, bounds)
    @modal_view = modal_view
    @keyboard_view = keyboard_view
    @table_view = UITableView.grouped(bounds) 
  end

  def create
    @table_view.dataSource = self
    @table_view.delegate = self
    @table_view
  end

  def tableView(table_view, cellForRowAtIndexPath:index_path)
    cell = table_view.dequeueReusableCellWithIdentifier('Cell')

    unless cell
      cell = UITableViewCell.alloc.initWithStyle(:value1.uitablecellstyle,   # !?
                                                  reuseIdentifier:'Cell')
      
    end

    puts "Numbers: #{Numbers[@numbers]}"
    cell.textLabel.text = Numbers[@numbers]

    return cell
  end

  def tableView(table_view, titleForHeaderInSection:section)
    "Środek transportu:"
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