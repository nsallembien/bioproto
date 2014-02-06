<@ page contentType="text/html;charset=UTF-8" >
<html xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
    <head>
        <meta name="layout" content="main"/>
        <r:require module="jquery"/>
        <r:require module="bigtable"/>
        <r:require module="bootstrap"/>
        <g:javascript library="jquery" plugin="jquery"/>
        <style>
#bigtable {
	height: 200px;
	width: 400px;
	border: solid 1px black;
}

#bigtable .bigtable-headers {
	height: 20px;
}

#bigtable .bigtable-body {
	height: 180px;
}

.bigtable-container {
	overflow: hidden;
	position: relative;
}

.bigtable-container table {
	table-layout: fixed;
	border-collapse: collapse;
	width: 1px;
	height: 1px;
}

.bigtable-headers {
	overflow: hidden;
	width: 100%;
	position: relative;
}

.bigtable-headers th {
	height: 20px;
	text-align: left;
}

.bigtable-body td {
	overflow: hidden;
	line-height: 20px;
	margin: 0;
	padding: 0;
}

.bigtable-body {
	width: 100%;
	overflow-y: scroll;
	overflow-x: auto;
	position: relative;
}
        </style>
    </head>
    <body>
        <section>
            <div class="container">
                <div class="row">
                    <header class="page-header">
                        <h3>John O'Ravenbien's <small class="lead">job List</small></h3>
                    </header>
                    <div class="span3">
                        <g:link class="btn btn-block btn-link" action="create">
                            Create New Job
                        </g:link>
                        <div class="well">
                            <ul class="nav nav-list">
                                <li class="nav-header">Jobs</li>
                                <li class="active">
                                    <a id="view-all" href="#">
                                        <i class="icon-chevron-right pull-right"></i>
                                        <b>View All</b>
                                    </a>
                                </li>
                            <g:each in="${ jobs }" var="job" status="i">
                                <li>
                                    <a href="#Job-${job.id}">
                                        <i class="icon-chevron-right pull-right"></i>
                                        ${ "${ job.name }" }
                                    </a>
                                </li>
                            </g:each>
                            </ul>
                        </div>
                    </div>
                    <div class="span9">
                    <g:each in="${ jobs }" var="job" status="i">
                        <div id="Job-${ job.id }" class="well well-small">
                            <table class="table table-bordered table-striped">
                                <caption>
                                    ${ "${ job.name } ${ job.status }" }: list of past results
                                </caption>
                                <thead>
                                    <tr>
                                        <th>Output</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <g:each in="${ job.results }" var="result">
                                    <tr>
                                        <td>
                                            <div style="height:500px; width: 80%; overflow-y: scroll; overflow-x: scroll" class="infinite-scroll">
                                            <g:if test="${result.isParsed()}">
                                                <g:render template="result"
                                                        model="[result:result, chunk:0]" />
                                            </g:if>
                                            <g:else>
                                                <g:render template="jsonResult"
                                                        model="[result:result, chunk:0]" />
                                            </g:else>
                                            </div>
                                        </td>
                                        <td><g:link class="btn btn-small btn-inverse" controller="jobresult"
                                                    action="delete" id="${result.id}">
                                                <i class="icon-edit icon-white"></i>Delete
                                            </g:link>
                                        </td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                            <div class="btn-group">
                                <g:link class="btn btn-primary" action="edit" id="${job.id}">
                                    <i class="icon-edit icon-white"></i>Edit
                                </g:link>
                            </div>
                        </div>
                    </g:each>
                    </div>
                </div>
            </div>
        </section>
        <g:javascript>
            $.ajax({
                url:"${g.createLink(controller:'job',action:'nextChunk_json', id:'2', chunk: '0')}",
                dataType: 'json',
                data: {
                },
                success: function(data) {
                    alert(data)
                },
                error: function(request, status, error) {
                    alert(error)
                },
                complete: function() {
                }
            });
            var myTable = new bigtable('bigtable', // id
					['Column 0', 'Column 1', 'Column 2', 'Column 3', 'Column 4', 'Column 5', 'Column 6', 'Column 7', 'Column 8', 'Column 9'], // column labels
					[[1,2,3,4,5,6,7,8,9,10],
					 [1,2,3,4,5,6,7,8,9,10],
					 [1,2,3,4,5,6,7,8,9,10],
					 [1,2,3,4,5,6,7,8,9,10],
					 [1,2,3,4,5,6,7,8,9,10],
					 [1,2,3,4,5,6,7,8,9,10]
                     ]// numRows
				);
            $('ul.nav > li > a').click(function(e){
               if($(this).attr('id') == "view-all"){
                   $('div[id*="Job-"]').fadeIn('fast');
               }else{
                   var aRef = $(this);
                   var tablesToHide = $('div[id*="Job-"]:visible').length > 1
                           ? $('div[id*="Job-"]:visible') : $($('.nav > li[class="active"] > a').attr('href'));
                   tablesToHide.hide();
                   $(aRef.attr('href')).fadeIn('fast');
               }
               $('.nav > li[class="active"]').removeClass('active');
               $(this).parent().addClass('active');
            });
        </g:javascript>
    </body>
</html>
