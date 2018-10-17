class TestsController < ApplicationController

  def index
    ap "Llamada a index"

    locations = [{ciudad: "Santiago,CL", ubicacion: "-33.45,-70.66667"}]
    response = HTTParty.get("https://api.darksky.net/forecast/c4871c7931a48c198eedf4ef9954f834/#{locations[0][:ubicacion]}")
    respuesta = JSON.parse(response.body)

    render json: {temperatura: respuesta["currently"]["temperature"], ciudad: locations[0][:ciudad] }
  end
end