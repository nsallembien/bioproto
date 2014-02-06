modules = {
    bigtable {
        resource url:'js/bigtable.js', attrs:[rel: "application/javascript"]
        dependsOn 'jquery'
    }
    bootstrap {
        resource url:'css/bootstrap.css', attrs:[rel: "stylesheet/css", type: 'css']
        dependsOn 'jquery'
    }
}
