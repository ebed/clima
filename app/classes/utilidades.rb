class Utilidades

  def self.parseaFechaFromTimestamp(time)
    time = Time.at( time )
    { fecha: time.strftime("%Y/%m/%d"), hora:  time.strftime("%H:%M")}
  end

  def self.obtieneURL(ubicacion)
    "https://api.darksky.net/forecast/#{ENV['KEYWEATHER']}/#{ubicacion}"
  end

end