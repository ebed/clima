App.canal_data = App.cable.subscriptions.create "CanalDataChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	console.log("ok");
  	$('#contenido').html('');
  	for d,v of data.datos  		
  			console.log(v)
	    $('#contenido').append ' <div class="col-sm-2 text-center  ">
		      <div class="panel panel-default">
				  <div class="panel-heading">'+v["ciudad"]+'</div>
				  <div class="panel-body">
				   	<table>
				   		<tr>
				   			<th > <h3> '+ v["hora"]+' </h3></th>
				   		</tr>
				   		<tr>
				   			<th> TEMPERATURA  </th> 
				   		</tr>
				   		<tr>
				   		<td> <h2>'+ v["temperatura"]+'° F</h2> </td>
				   		</tr>
				   		<tr>
				   		<td> <h2>'+ v["temperaturac"]+'° C</h2> </td>
				   		</tr>
				  </div>
				</div>
		    </div>';
