<!DOCTYPE html>

<!-- This file is part of SPINderella. It is subject to the license terms in
     the LICENSE file found in the top-level directory of this distribution.
     You may not use this file except in compliance with the License. -->

<html lang="en">
<head>
    <title>SPINderella</title>
    <meta charset="utf-8">
    
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://codemirror.net/lib/codemirror.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="https://codemirror.net/lib/codemirror.js"></script>
    <script src="http://codemirror.net/mode/turtle/turtle.js"></script>
    <script src="http://codemirror.net/mode/sparql/sparql.js"></script>
    <script src="http://codemirror.net/mode/xml/xml.js"></script>
    <script src="https://codemirror.net/addon/display/autorefresh.js"></script>
    <script src="http://www.appelsiini.net/projects/chained/jquery.chained.min.js"></script>
    
<style type="text/css">
    html, body {
        height: 100%;
        margin: 0px;
    }
    .nav {
        /* background: #e3d235; */
    }
    .panel-body {
        height: 100%;
        /* background: #f0e68c; */
    }
    .CodeMirror {
        border: 1px solid #eee;
        height: auto;
    }
    .outerPanel {
        padding-top: 10px;
        padding-right: 10px;
        padding-bottom: 10px;
        padding-left: 10px;
        background: #f2f2f2
    }
</style>    
</head>
    
<body>
        
<div class="container">
    <br/>
    <div class="panel panel-default outerPanel">
    <div class="panel panel-default">
        <div class="panel-body">
            <p><b>SPINderella</b> provides a REST API to convert between textual SPARQL syntax and the SPIN RDF Vocabulary.</p>
        </div>
    </div>
    
    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#home">SPARQL to SPIN</a></li>
        <li><a data-toggle="tab" href="#menu1">SPIN to SPARQL</a></li>
        <li><a data-toggle="tab" href="#menu2">Output</a></li>
        <li><a data-toggle="tab" href="#menu3">About</a></li>
    </ul>

    <div class="panel panel-default">
        <div class="panel-body">
            <div class="tab-content">
                <div id="home" class="tab-pane fade in active">
                    <br/>
                    <form class="form-horizontal" id="sparql2spin">
                        <fieldset>
                            <div class="form-group row">
                                <label class="col-md-2 control-label" for="spinQueryURI">SPIN Query URI</label>  
                                <div class="col-md-10">
                                    <input id="spinQueryURI" name=""spinQueryURI"" type="text" placeholder="http://example.com/mySPINQuery" class="form-control input-md">   
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-2 control-label" for="sparqlQueryText">SPARQL Query</label>
                                <div class="col-md-10">                     
                                    <textarea class="form-control" id="sparqlQueryText" rows="10" name="sparqlQueryText" required="" placeholder="Place your SPARQL query here."></textarea>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-2 control-label" for="submit"></label>
                                <div class="col-md-10">
                                    <button id="submit" name="submit" class="btn btn-info">Convert to SPIN</button>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>
            
                <div id="menu1" class="tab-pane fade">
                    <form class="form-horizontal" id="spin2sparql">
                        <fieldset>
                            <div class="form-group row">
                                <label class="col-md-2 control-label" for="spinQueryText">SPIN Query</label>
                                <div class="col-md-10">                     
                                    <textarea class="form-control" id="spinQueryText" name="spinQueryText" rows="10" required="" placeholder="Place your SPIN query here."></textarea>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-2 control-label" for="submit"></label>
                                <div class="col-md-10">
                                    <button id="submit" name="submit" class="btn btn-info">Convert to SPARQL</button>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>

                <div id="menu2" class="tab-pane fade">
                    <form>
                        <textarea id="editor" name="editor"></textarea>
                    </form>
                </div>
                    
                <div id="menu3" class="tab-pane fade">
                    <h3>What does SPINderella do?</h3>
                    <p>SPINderella provides a REST API to convert between textual <a href="https://www.w3.org/TR/sparql11-overview/">SPARQL syntax</a> and the <a href="http://spinrdf.org/">SPIN RDF Vocabulary</a>.</p> 
                    <h3>Get your own SPINderella!</h3>
                    <p>The source code of this tool is available from <a href="https://github.com/rmrschub/spinderella">GitHub</a>.
                </div>
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-body">
                <p>This work has been supported by the <a href="http://www.bmbf.de/en/index.html">German Ministry for Education and Research (BMBF)</a> as part of the <a href="http://www.arvida.de/">ARVIDA project.</a></p>
            </div>
        </div>
    </div>    
</div> 
    
<script type="text/javascript">
    var editor = CodeMirror.fromTextArea(document.getElementById("editor"), {
        viewportMargin: Infinity,
        readOnly: true,
        styleActiveLine: true,
        mode: "text/x-java",
        autoRefresh: true
    });
    $('#editor').data('CodeMirrorInstance', editor);
</script>
   
<script type="text/javascript">
    $("#spin2sparql").submit(function(event) {
        event.preventDefault();      
        $.post(
            "api/spin/sparql",
            {
            	spinQueryText: $("#spinQueryText").val()
            },
            function(data) {
                $('.nav-tabs a[href="#menu2"]').tab('show');
                var editor = $('#editor').data('CodeMirrorInstance');
                editor.setOption("mode", "application/sparql-query");
                editor.getDoc().setValue(data);
                editor.refresh();
            }
        );
        
    });
</script>

<script type="text/javascript">
    $("#sparql2spin").submit(function(event) {
        event.preventDefault();      
        $.post(
            "api/sparql/spin",
            {
            	spinQueryURI: $("#spinQueryURI").val(),
            	sparqlQueryText: $("#sparqlQueryText").val(),
            },
            function(data) {
                $('.nav-tabs a[href="#menu2"]').tab('show');
                var editor = $('#editor').data('CodeMirrorInstance');
                editor.setOption("mode", "text/turtle");
                editor.getDoc().setValue(data);
                editor.refresh();
            }
        );
        
    });
</script>

<style type='text/css'>@import url('http://getbarometer.s3.amazonaws.com/assets/barometer/css/barometer.css');</style>
<script src='http://getbarometer.s3.amazonaws.com/assets/barometer/javascripts/barometer.js' type='text/javascript'></script>
<script type="text/javascript" charset="utf-8">
  BAROMETER.load('D2D88y7fGGhLd72ahB937');
</script>        

</body>
</html>