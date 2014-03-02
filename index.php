<?php

$filename = date('Ymd').'_'.time().'.html';
ob_start();

?>
<html>
<head>
	<title>Quick INS Checker Script</title>
</head>

<body>

	<h3>Here are your parameters:</h3>
	
	<h4>POST</h4>
	
	<pre>
<?php print_r($_POST); ?>
	</pre>	
	
	<h4>GET</h4>
	
	<pre>
<?php print_r($_GET); ?>
	</pre>

	<?php

if ( ! empty($_POST) || ! empty($_GET) )
{
	$content = ob_get_contents();
	file_put_contents($filename, $content);
	
	echo '<p>You can find a copy of this page <a href="./'.$filename.'">here</a>.</p>';
}

// Closing down the page.
?>
</body>
</html>