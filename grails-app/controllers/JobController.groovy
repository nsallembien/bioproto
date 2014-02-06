import com.bioproto.Job
import com.bioproto.JobResult

import grails.converters.JSON

class JobController {

    def scaffold = Job

    def index = {
        def jobs = Job.list([sort: "id", order:"desc"])

        return [jobs: jobs]
    }

    def nextChunk = {
        def jobResult = JobResult.get(params.id)
        render(template: "result", model: [result: jobResult, chunk: params.int('chunk')])
    }

    def nextChunk_json = {
        def jobResult = JobResult.get(params.id)
        render jobResult.jsonOutput(params.int('chunk')) as JSON
    }
}
