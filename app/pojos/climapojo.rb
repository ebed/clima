class Climapojo
  attr_accessor :ciudad,:hora, :fecha, :temperatura, :temperaturac
  def initialize(ciudad, hora, fecha, temperatura, temperaturac)
    @ciudad = ciudad
    @hora = hora
    @fecha = fecha 
    @temperatura = temperatura
    @temperaturac = temperaturac
  end



end