class InformacionController < ApplicationController
  def index
    r = Recuperainformacion.new
    @datosiniciales = r.getDataWeatherPojo
  end
end
