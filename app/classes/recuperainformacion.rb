class Recuperainformacion


  def self.listadoCiudades
     [
        {ciudad: "Santiago,CL", ubicacion: "-33.45,-70.66667"},
        {ciudad: "Zurich,CH", ubicacion: "47.37861,8,54"},
        {ciudad: "Auckland,NZ", ubicacion: "-36.85,174.78333"},
        {ciudad: "Sidney,AU", ubicacion: "-33.868,151.21"}, 
       {ciudad: "Londres,UK", ubicacion: "51.50722,-0.1275"}, 
        {ciudad: "Georgia,USA", ubicacion: "32.674684,-83.25066"}
     ]
  end

  def self.obtiene
    resp = []
    listadoCiudades.each do |ciudad|
      response = HTTParty.get("https://api.darksky.net/forecast/c4871c7931a48c198eedf4ef9954f834/#{ciudad[:ubicacion]}")
      respuesta = JSON.parse(response.body)

      time = Time.at( respuesta["currently"]["time"] )
      fecha = time.strftime("%Y/%m/%d")
      hora = time.strftime("%H:%M")

      temp = {temperatura: respuesta["currently"]["temperature"], ciudad: ciudad[:ciudad], hora: hora, fecha: fecha  }
      resp << temp
    end
    resp
  end
    
   

end