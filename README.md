# README

# Sistema para AcidLabs. 

Provee una plataforma que por medio de tareas en segundo plano, carga desde la api de climas, las temperaturas de las ciudades indicadas. Esto queda disponible en REDIS para ser obtenido desde la web en su primera carga.

En paralelo, una tarea programada se encarga de enviar por medio de ActionCable las actualizaciones de los datos al frontend por medio de un WebSocket.

Se utilizaron para producción, un servidor redis para mantener todo lo relacionado a las tareas programadas y los datos, y otro servidor redis dedicado a dar servicio a ActionCable. 

Para el frontend, se utilizó Bootstrap como gema. Se evaluó el utilizar bower para traer, pero era complejizar mucho la solución.

Solo se almacenan las ultimas temperaturas de cada ciudad, no guardando un registro historico. Para esto se pudo habilitar una base de datos, y se pudo generar gráficos por medio de alguna libreria como NVD3.
Además se evaluó poner en frente un servidor NGINX, dando la capacidad de escalar de ser necesario. 


# VER DATOS EN REDIS
Se disponibiliza en el sitio REDIS-BROWSER, que entrega la posibilidad de navegar en los datos almacenados en la conección PRODUCCION.  

https://appweathertest.herokuapp.com/redis-browser

- Usuario: test 
- Passwd: 123


Para ver los datos de las ubicaciones:

## api.localizaciones 
Aquí se almacenan las ubicaciones geográficas de cada ciudad.


Para ver los datos del clima
## api.datos 

Aquí se almacenan las últimas temperaturas de cada ciudad.


Para ver los datos de los errores
## api.errors
Aquí se almacenan los casos de error al tratar de conectar con la API para obtener la información.


# CLASES IMPORTANTES

Se utilizan las siguientes clases para prestar algunas funcionalidades:

## Recuperainformacion: 

En esta se tiene la labor de:

  - Obtener las ciudades y recuperar las temperaturas desde API. 
  - Recuperar los datos almacenados en REDIS para ser utilizados tanto por el controlador Informacion para desplegar en pantalla, como por ActionCable que lo envia a js para hacer update del DOM con la información. 



## Utilidades: 

Provee utilidades simples:

- Renderiza la fecha y la deja en el TimeZone de Santiago.
- Calcula temperatura en Celcius
- Obtiene la URL de la API


## refresh_worker

En el Worker que refresca la información, utiliza el manejo de la excepción lanzada cada vez que se llama al inicializador de Recuperainformacion. En el caso de lanzar la excepción, se lanza al logger y se guarda en Redis en api.errors, con la llave del timestamp actual y el mensaje.

En el caso de que no haya excepción, se recuperarán las temperaturas desde la Api y se enviarán al front por el ActionCable.

    begin 
      r = Recuperainformacion.new 
      r.obtieneTemperaturas 
      r.pushDataChannel
    rescue => e 
      logger.info e
      $errores.set(Time.now, e.message )
    end

