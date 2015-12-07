<!DOCTYPE html>
<html>
<head>
	<title>PR Beers</title>

	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name=viewport content="initial-scale=1">

	<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/base-min.css">
	<link rel="stylesheet" type="text/css" href="prbeers.css">
</head>
<body>
<div class="header">
	<h1>PR::Beers [bazooka-ci]</h1>
</div>
<div class="content">
<table class="owes">
	<thead>
		<tr>
			<th>Owes</th>
			{{range .Users}}
			<th>
				<img src="{{.Avatar}}" alt="{{.Login}}">
			</th>
			{{end}}
		</tr>
	</thead>
	<tbody>
		{{range .Users}}
		<tr>
			<td>
				<img src="{{.Avatar}}" alt="{{.Login}}">
			</td>
			{{$victim := .Login}}
			{{range $.Users}}
				{{$beneficiary := .Login}}
				{{$debt := index $.Debts $victim $beneficiary}}
				<td>
					{{if gt $debt 0}}
					<a href="#" data-beer-victim="{{$victim}}" data-beer-beneficiary="{{$beneficiary}}">
						{{$debt}} &#x1f37a;
					</a>
					{{end}}
				</td>
			{{end}}
			
		</tr>
		{{end}}
	</tbody>
</table>
</div>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script>
	$(function(){
		$('.owes').on('click', 'a', function(ev){
			
			var victim = $(this).data('beer-victim'),
			beneficiary = $(this).data('beer-beneficiary');
			console.log(victim, 'pays', beneficiary);

			if(confirm("I, "+victim+", solomnly swear on the brow code that I am paying a beer for "+beneficiary+" to attone for me wronging him by not reviewing one of his pull requests for god knows how long. Do you swear ?")) {
				
				console.log('yep');
				$.post('/payup', {victim: victim, beneficiary: beneficiary}, function(response){
					console.log('got response', response);
					location.reload();
				})
			}
		});
	})
</script>
</body>
</html>
<!-- 
avatars:

jawher: https://avatars.githubusercontent.com/u/96384?v=3
julien: https://avatars.githubusercontent.com/u/455944?v=3
eric:   https://avatars.githubusercontent.com/u/4128?v=3
 -->