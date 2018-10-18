class Recuperainformacion

  def initialize
    raise StandardError.new('How unfortunate! The API Request Failed')  if Random.new.rand(10) < 1
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
    if $localizaciones.keys.size == 0
      cargaCiudadesRedis
    end
    $localizaciones.keys.each do |llave|
      ubicacion= $localizaciones.get(llave) 
      respuesta = JSON.parse(HTTParty.get(Utilidades.obtieneURL(ubicacion)).body)
      parsed_fecha = Utilidades.parseaFechaFromTimestamp(respuesta["currently"]["time"]) 
      temp = Hash.new
      temp["temperatura"] = respuesta["currently"]["temperature"]
      temp["ciudad"] = llave 
      temp["hora"] = parsed_fecha[:hora]
      temp["fecha"] = parsed_fecha[:fecha] 
       
      $data.set(llave, temp.to_json)
       
    end
  end


  def getDataWeather
    resp=[]
    $data.keys.each do |key|
      dato = JSON.parse $data.get(key)
    #  ap dato
      temp= {ciudad: key, temperatura: dato["temperatura"].round(1), temperaturac: Utilidades.farenheit2Celcius(dato["temperatura"]), fecha: dato["fecha"], hora: dato["hora"]}
      resp << temp
    end
    resp
  end


  def pushDataChannel
    datos = getDataWeather
  # ap datos
    ActionCable.server.broadcast "datosclima_channel", datos: getDataWeather
  end


end