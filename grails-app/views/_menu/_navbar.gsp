<nav id="Navbar" class="navbar navbar-fixed-top navbar-inverse" role="navigation" style="background-color:#ffffff;border:0px;">
    	<a class="navbar-brand" href="${createLink(uri: '/')}">
			<img class="logo" src="${resource(plugin: 'kickstart', dir:'images', file:'brand_logo.png')}" alt="${meta(name:'app.name')}" width="226px" height="78px"/> 
	    </a>
	<div class="container" style="color:#ffffff">
	
	    <div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
        		<span class="sr-only">Toggle navigation</span>
        		<span class="icon-bar"></span>
	           	<span class="icon-bar"></span>
	           	<span class="icon-bar"></span>
			</button>
		</div>

		<div class="collapse navbar-collapse navbar-ex1-collapse" role="navigation">

    	<ul class="nav navbar-nav navbar-right">
 			<g:render template="/_menu/search"/> 
			<g:render template="/_menu/admin"/>														
			<g:render template="/_menu/info"/>														
			<g:render template="/_menu/user"/><!-- NOTE: the renderDialog for the "Register" modal dialog MUST be placed outside the NavBar (at least for Bootstrap 2.1.1): see bottom of main.gsp -->
	    </ul>			

		</div>
	</div>
</nav>
