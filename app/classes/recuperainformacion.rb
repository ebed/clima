class Recuperainformacion

  def initialize
    throw new Error('How unfortunate! The API Request Failed')  if Random.new.rand(10) < 1
  end


  def listadoCiudades
     [
        {ciudad: "Santiago,CL", ubicacion: "-33.45,-70.66667"},
        {ciudad: "Zurich,CH", ubicacion: "47.37861,8,54"},
        {ciudad: "Auckland,NZ", ubicacion: "-36.85,174.78333"},
        {ciudad: "Sidney,AU", ubicacion: "-33.868,151.21"}, 
        {ciudad: "Londres,UK", ubicacion: "51.50722,-0.1275"}, 
        {ciudad: "Georgia,USA", ubicacion: "32.674684,-83.25066"}
     ]
  end

  def obtieneTemperaturas
    resp = []
    listadoCiudades.each do |ciudad|
      response = HTTParty.get(Utilidades.obtieneURL(ciudad))
      respuesta = JSON.parse(response.body)
      parsed_fecha = Utilidades.parseaFechaFromTimestamp(respuesta["currently"]["time"]) 
      temp = {temperatura: respuesta["currently"]["temperature"], ciudad: ciudad[:ciudad], hora: parsed_fecha[:hora], fecha: parsed_fecha[:fecha]  }
      resp << temp
    end
    resp
  end

end