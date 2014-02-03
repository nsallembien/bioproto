import com.bioproto.Job
import com.bioproto.JobResult

class JobController {

    def scaffold = Job

    def index = {
        def jobs = Job.list([sort: "id", order:"desc"])

        return [jobs: jobs]
    }

    def nextChunk = {
        def jobResult = JobResult.get(params.id)
        render {
            p(id: 'outputparagraph', raw(jobResult.htmlOutput(params.int('chunk'))))
            link(class: 'jscroll-next', action: 'nextChunk', id: params.id, chunk: params.int('chunk') + 1, 'next') 
        }
    }
}
