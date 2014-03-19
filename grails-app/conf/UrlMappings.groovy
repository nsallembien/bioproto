class UrlMappings {

	static mappings = {
        "/dataset/$id/chunk/$chunk"(controller: "dataset", action: "nextChunk")
        "/dataset/$id/chunk.json/$chunk"(controller: "dataset", action: "nextChunk_json")
        "/$controller/list"(action: "index") 
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')
        "404"(view:'/404')
        "/login/$action?"(controller: "login")
        "/logout/$action?"(controller: "logout")
	}
}
