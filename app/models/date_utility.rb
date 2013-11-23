class DateUtility
  
  def self.get_date(created_at)
  	formatter = NSDateFormatter.new
    formatter.setDateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZ")
    date = formatter.dateFromString(created_at)

    calendar = NSCalendar.currentCalendar
    components = calendar.components(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit, fromDate:date)
    
    day = components.day < 10 ? "0#{components.day}" : components.day
    month = components.month < 10 ? "0#{components.month}" : components.month
    "#{day}-#{month}-#{components.year}"
  end

  def self.get_time(created_at)
    formatter = NSDateFormatter.new
    formatter.setDateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZ")
    date = formatter.dateFromString(created_at)

    calendar = NSCalendar.currentCalendar
    components = calendar.components(NSHourCalendarUnit|NSMinuteCalendarUnit, fromDate:date)
    
    hour = components.hour < 10 ? "0#{components.hour}" : components.hour
    minute = components.minute < 10 ? "0#{components.minute}" : components.minute
    "#{hour}:#{minute}"
  end
end