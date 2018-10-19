require 'rails_helper'
RSpec.describe Utilidades  do
  it "debe retornar la hora desde string" do 
    fecha_milisegundos = 1539987929
    time = Time.at(fecha_milisegundos).in_time_zone("America/Santiago")
    hora=  time.strftime("%H:%M")
    expect(Utilidades.parseaFechaFromTimestamp(fecha_milisegundos)[:hora]).to eq(hora)
  end

 it "debe retornar la fecha desde string" do 
    fecha_milisegundos = 1539987929
    time = Time.at(fecha_milisegundos).in_time_zone("America/Santiago")
    fecha=  time.strftime("%Y/%m/%d")
    expect(Utilidades.parseaFechaFromTimestamp(fecha_milisegundos)[:fecha]).to eq(fecha)
  end


  it "debe retornar la url de la api de forecast" do 
    url = "https://api.darksky.net/forecast/#{ENV['KEYWEATHER']}/10,10"
    expect(Utilidades.obtieneURL("10,10")).to eq(url)
  end

  it "Debe calcular la temperatura de farenheit a Celcious" do 
    farenheit = 70
    celcius = 21.1 
    expect(Utilidades.farenheit2Celcius(70)).to eq(celcius)
  end

end
  