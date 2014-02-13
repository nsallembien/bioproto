import com.bioproto.Dataset

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class DatasetController {

    def scaffold = Dataset

    def index = {
        def datasets = getAuthenticatedUser().getDatasets()

        return [datasets: datasets]
    }

    def nextChunk = {
        def dataset = Dataset.get(params.id)
        render(template: "chunk", model: [result: dataset, chunk: params.int('chunk')])
    }

    def nextChunk_json = {
        def dataset = Dataset.get(params.id)
        render dataset.formattedChunk(params.int('chunk')) as JSON
    }
}
