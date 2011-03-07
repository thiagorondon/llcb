
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
				htm = htm + "\n\n";
	
				htm = htm + "<iframe width=425 height=350 frameborder=0 scrolling=no marginheight=0 marginwidth=0 src='http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=" + ret.latitude + "," + ret.longitude + "&amp;ie=UTF8&amp;z=9&amp;output=embed'></iframe><br /><small><a href='http://maps.google.com/mape?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=" + ret.latitude + "," + ret.longitude + "&amp;aq=&amp;ie=UTF8&amp;z=9&amp;ll=0.894434,-59.686687' style='color:#0000FF;text-align:left'>View Larger Map</a></small>";


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


