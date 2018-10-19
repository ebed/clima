class Utilidades

  def self.parseaFechaFromTimestamp(time)
    time = Time.at( time ).in_time_zone("America/Santiago")

    { fecha: time.strftime("%Y/%m/%d"), hora:  time.strftime("%H:%M")}
  end

  def self.obtieneURL(ubicacion)
    "https://api.darksky.net/forecast/#{ENV['KEYWEATHER']}/#{ubicacion}"
  end

  def self.farenheit2Celcius(k)
    ((k - 32) / 1.8).round(1)
  end
end