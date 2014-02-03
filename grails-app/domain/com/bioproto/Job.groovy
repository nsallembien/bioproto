package com.bioproto

class Job {

    String name;
    String status;

    static belongsTo = [owner: User]
    static hasMany = [results: JobResult]

    static constraints = {
    }
}
