import com.bioproto.User
import com.bioproto.UserRole
import com.bioproto.Role
import com.bioproto.Job
import com.bioproto.JobResult

class BootStrap {

    def init = { servletContext ->

        // Bootstrap roles and users
        def userRole = Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(failOnError: true)

        def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(failOnError: true)
        def adminUser = User.findByUsername('admin') ?: new User( username: 'admin', password: 'admin', enabled: true, email: 'nsallembien@gmail.com').save(failOnError: true)

        if (!adminUser.authorities.contains(adminRole)) { UserRole.create adminUser, adminRole }

        // Bootstrap some test jobs
        def exampleJobFinished = new Job(name: "This is a another job", status: "finished")
        exampleJobFinished.owner = adminUser
        exampleJobFinished.save(failOnError: true)
        def exampleJobResult = new JobResult (output: """\
10/05/08 17:43:00 INFO input.FileInputFormat: Total input paths to process : 3
10/05/08 17:43:01 INFO mapred.JobClient: Running job: job_201005081732_0001
10/05/08 17:43:02 INFO mapred.JobClient:  map 0% reduce 0%
10/05/08 17:43:14 INFO mapred.JobClient:  map 66% reduce 0%
10/05/08 17:43:17 INFO mapred.JobClient:  map 100% reduce 0%
10/05/08 17:43:26 INFO mapred.JobClient:  map 100% reduce 100%
10/05/08 17:43:28 INFO mapred.JobClient: Job complete: job_201005081732_0001
10/05/08 17:43:28 INFO mapred.JobClient: Counters: 17
10/05/08 17:43:28 INFO mapred.JobClient:   Job Counters
10/05/08 17:43:28 INFO mapred.JobClient:     Launched reduce tasks=1
10/05/08 17:43:28 INFO mapred.JobClient:     Launched map tasks=3
10/05/08 17:43:28 INFO mapred.JobClient:     Data-local map tasks=3
10/05/08 17:43:28 INFO mapred.JobClient:   FileSystemCounters
10/05/08 17:43:28 INFO mapred.JobClient:     FILE_BYTES_READ=2214026
10/05/08 17:43:28 INFO mapred.JobClient:     HDFS_BYTES_READ=3639512
10/05/08 17:43:28 INFO mapred.JobClient:     FILE_BYTES_WRITTEN=3687918
10/05/08 17:43:28 INFO mapred.JobClient:     HDFS_BYTES_WRITTEN=880330
10/05/08 17:43:28 INFO mapred.JobClient:   Map-Reduce Framework
10/05/08 17:43:28 INFO mapred.JobClient:     Reduce input groups=82290
10/05/08 17:43:28 INFO mapred.JobClient:     Combine output records=102286
10/05/08 17:43:28 INFO mapred.JobClient:     Map input records=77934
10/05/08 17:43:28 INFO mapred.JobClient:     Reduce shuffle bytes=1473796
10/05/08 17:43:28 INFO mapred.JobClient:     Reduce output records=82290
10/05/08 17:43:28 INFO mapred.JobClient:     Spilled Records=255874
10/05/08 17:43:28 INFO mapred.JobClient:     Map output bytes=6076267
10/05/08 17:43:28 INFO mapred.JobClient:     Combine input records=629187
10/05/08 17:43:28 INFO mapred.JobClient:     Map output records=629187
10/05/08 17:43:28 INFO mapred.JobClient:     Reduce input records=102286"""
                )
        exampleJobResult.job = exampleJobFinished
        exampleJobResult.parsed = false
        exampleJobResult.save(failOnError: true)

        def exampleJob = new Job(name: "This is a running job", status: "in progress")
        exampleJob.owner = adminUser
        exampleJob.save(failOnError: true)

        def exampleJobResultHdfs = new JobResult(hdfsOutputPath: "hdfs://localhost/user/hadoop/Omniture.tsv")
        exampleJobResultHdfs.job = exampleJob
        exampleJobResult.parsed = true
        exampleJobResultHdfs.save(failOnError: true)

    }

    def destroy = {
    }
}
