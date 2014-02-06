class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')
        "/login/$action?"(controller: "login")
        "/logout/$action?"(controller: "logout")
        "/result/$id/chunk/$chunk"(controller: "job", action: "nextChunk")
        "/result/$id/chunk.json/$chunk"(controller: "job", action: "nextChunk_json")
	}
}
