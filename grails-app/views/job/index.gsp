<@ page contentType="text/html;charset=UTF-8" >
<html xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
    <head>
        <meta name="layout" content="main"/>
        <r:require modules="jquery"/>
        <r:require modules="bootstrap"/>
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
                                            <div style="height:500px; overflow-y: scroll" class="infinite-scroll">
                                                <g:render template="result"
                                                        model="[result:result, chunk:0]" />
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
        <jq:plugin name="jscroll"/>
        <g:javascript>
            $('ul.nav > li > a').click(function(e){
                if($(this).attr('id') == "view-all"){
                    $('div[id*="Job-"]').fadeIn('fast');
                }else{
                    var aRef = $(this);
                    var tablesToHide = $('div[id*="Person-"]:visible').length > 1
                            ? $('div[id*="Person-"]:visible') : $($('.nav > li[class="active"] > a').attr('href'));

                    tablesToHide.hide();
                    $(aRef.attr('href')).fadeIn('fast');
                }
                $('.nav > li[class="active"]').removeClass('active');
                $(this).parent().addClass('active');
            });
            $('div.infinite-scroll').jscroll({
                nextSelector: 'a.jscroll-next:last'
            });
        </g:javascript>
    </body>
</html>
