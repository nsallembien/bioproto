<!DOCTYPE html>
<html>
	<head>
		<title>404 Not Found</title>
		<meta name="layout" content="main">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
	</head>
	<body>
		<ul class="errors">
			<li>There is nothing to see here.</li>
            <li>Perhaps you wanted to <g:link controller="login" action="auth">login</g:link>?</li>
		</ul>
	</body>
</html>
