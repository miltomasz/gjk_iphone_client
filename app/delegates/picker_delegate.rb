class AwesomePickerDelegate
  def numberOfComponentsInPickerView(picker_view)
    1
  end

  def pickerView(picker_view, numberOfRowsInComponent:section)
    Numbers.length
  end

  def pickerView(picker_view, titleForRow:row, forComponent:section)
    Numbers[row].to_s
  end
end