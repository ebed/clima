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

  def cargaCiudadesRedis
    listadoCiudades.each do |ciudad|
      $localizaciones.set(ciudad[:ciudad], ciudad[:ubicacion])
    end
  end

  def obtieneTemperaturas
    $localizaciones.keys.each do |llave|
      ubicacion= $localizaciones.get(llave) 
      response = HTTParty.get(Utilidades.obtieneURL(ubicacion))
      respuesta = JSON.parse(response.body)
      parsed_fecha = Utilidades.parseaFechaFromTimestamp(respuesta["currently"]["time"]) 
      temp = Hash.new
      temp["temperatura"] = respuesta["currently"]["temperature"]
      temp["ciudad"] = llave 
      temp["hora"] = parsed_fecha[:hora]
      temp["fecha"] = parsed_fecha[:fecha] 
       
      $data.set(llave, temp.to_json)
       
    end
     
  end

end