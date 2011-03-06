
$(function() {
	$('.error').hide();
	$('#cidades').hide();
	$('#cidade_view').hide();


	$('#cidades').change( function(value) {
		var code = $('#cidades option:selected').val();
		
		var url_string = "/api/" + code;
		
		$.getJSON(url_string,
			function(data) {
				var ret = data.llcb[0];
				var htm = "Código IBGE: " + ret.codigo;
				htm = htm + "<br/>Latitude: " + ret.latitude;
				htm = htm + "<br/>Longitude: " + ret.longitude;
				$('#cidade_view').html(htm);
				$('#cidade_view').show();
			});
		
	});

	$('#estado').change( function(value) {
		var estado = $('#estado option:selected').val();
		$('#cidade_view').hide();	
		if (estado == "") {
			$('#cidades').hide();
			return false;
		
		}

		var url_string = "/api/" + estado;

		$.getJSON(url_string, 
			function (data) {
				var items = '<select id="cidade" name="cidade">\n';
				items = items + '<option value=""></option>\n';
				$.each(data.llcb, function (i,value) {
					items = items + 
						'<option value="' + value.codigo + '">' + value.cidade + '</option>\n';
					
				});

				$('#cidades').html(items + '</select>\n');
				$('#cidades').show();
			}
			);
		return false;
	});

});


