modules = {
    bootstrap {
        resource url:'css/bootstrap.css', attrs:[rel: "stylesheet/css", type: 'css']
        dependsOn 'jquery'
    }
}
