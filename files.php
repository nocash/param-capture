<html>
<head>
	<title>INS Files</title>
</head>

<body>

<pre>
<?php

$files = scandir('./', 1);

foreach ( $files as $file )
{
	echo '<a href="./'.$file.'">'.$file.'</a>'."\n";
}

?>
</pre>
</body>
</html>