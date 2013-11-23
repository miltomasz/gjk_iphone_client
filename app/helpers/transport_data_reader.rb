class TransportDataReader
  def self.read(file_name)
    File.read(file_name)
  end

  def self.parse(json)
    BW::JSON.parse(json)
  end
end