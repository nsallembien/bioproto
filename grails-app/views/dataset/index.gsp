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
	height: 500px;
	width: 1024px;
}

#bigtable .bigtable-headers {
	height: 20px;
}

#bigtable .bigtable-body {
	height: 480px;
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
    background-color: rgb(255,255,255);
}

.bigtable-headers {
	overflow: hidden;
	width: 100%;
	position: relative;
	border-bottom: 1px solid rgb(221, 221, 221);
	border-top: 1px solid rgb(221, 221, 221);
}

.bigtable-headers th {
	height: 20px;
	text-align: left;
	border-left: 1px solid rgb(221, 221, 221);
	border-right: 1px solid rgb(221, 221, 221);
}

.bigtable-body td {
	overflow: hidden;
	line-height: 20px;
    white-space: nowrap;
	margin: 0;
	padding: 0;
	border: 1px solid rgb(221, 221, 221);
    background-color: rgb(255,255,255);
}

.bigtable-body {
	width: 100%;
	overflow-y: scroll;
	overflow-x: auto;
	position: relative;
    background-color: rgb(255,255,255);
}
        </style>
    </head>
    <body>
        <section>
            <div class="container">
                <div class="row">
                    <header class="page-header">
                        <h3>John O'Ravenbien's <small class="lead">Datasets</small></h3>
                    </header>
                    <div class="span3">
                        <div class="well">
                            <ul class="nav nav-list">
                                <li class="nav-header">Current Datasets</li>
                                <li class="active">
                                    <a id="view-all" href="#">
                                        <i class="icon-chevron-right pull-right"></i>
                                        <b>View All</b>
                                    </a>
                                </li>
                            <g:each in="${ datasets }" var="dst" status="i">
                                <li>
                                    <a href="#Dataset-${dst.id}">
                                        <i class="icon-chevron-right pull-right"></i>
                                        ${ "${ dst.name }" }
                                    </a>
                                </li>
                            </g:each>
                            </ul>
                        </div>
                    </div>
                    <div class="span9">
                    <g:each in="${ datasets }" var="dst" status="i">
                        <div id="Dataset-${ dst.id }" class="well well-small">
                            <div class="btn-group">
                                <g:link class="btn btn-primary" action="edit" id="${dst.id}">
                                    <i class="icon-edit icon-white"></i>Edit
                                </g:link>
                                <g:link class="btn btn-primary" controller="dataset"
                                    action="delete" id="${dst.id}">
                                    <i class="icon-delete icon-white"></i>Delete
                                </g:link>
                            </div>
                            <table class="table table-bordered table-striped">
                                <caption>
                                    ${ "${ dst.name } – ${ dst.status }" }
                                </caption>
                                <thead>
                                    <tr>
                                        <th>Content</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <div style="height:500px">
                                            <g:if test="${dst.isParsed()}">
                                                <g:render template="jsonChunk" model="[dataset:dst, chunk:0]" />
                                            </g:if>
                                            <g:else>
                                                <g:render template="chunk" model="[dataset:dst, chunk:0]" />
                                            </g:else>
                                            </div>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </g:each>
                    </div>
                </div>
            </div>
        </section>
        <g:javascript>
            $.ajax({
                url:"/bi-prototype/dataset/2/chunk.json/0",
                dataType: 'json',
                data: {},
                success: function(data) {
                    var columns = [];
                    for (var i = 0; i < data[0].length; i++) {
                        columns.push("Column " + i);
                    }
                    new bigtable('bigtable', columns, data);
                },
                error: function(request, status, error) {
                    alert(error)
                },
                complete: function() {
                }
            });
            $('ul.nav > li > a').click(function(e){
               if($(this).attr('id') == "view-all"){
                   $('div[id*="Dataset-"]').fadeIn('fast');
               }else{
                   var aRef = $(this);
                   var tablesToHide = $('div[id*="Dataset-"]:visible').length > 1
                           ? $('div[id*="Dataset-"]:visible') : $($('.nav > li[class="active"] > a').attr('href'));
                   tablesToHide.hide();
                   $(aRef.attr('href')).fadeIn('fast');
               }
               $('.nav > li[class="active"]').removeClass('active');
               $(this).parent().addClass('active');
            });
        </g:javascript>
    </body>
</html>
