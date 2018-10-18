class RefreshWorker
  include Sidekiq::Worker

  def perform(*args)
    begin 
      r = Recuperainformacion.new 

      r.obtieneTemperaturas 
      r.pushDataChannel
    rescue => e 
      logger.info e
      $errores.set(Time.now, e.message )
    end
  end
end
