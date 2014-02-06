package com.bioproto;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;


class HdfsReader {

    Configuration conf;
    FileSystem fileSystem;

    HdfsReader() {
        def env = System.getenv()
        String HADOOP_HOME = env["HADOOP_HOME"];
        println HADOOP_HOME

        conf = new Configuration();
        conf.addResource(new Path(HADOOP_HOME, "etc/hadoop/core-site.xml"));
        conf.addResource(new Path(HADOOP_HOME, "etc/hadoop/hdfs-site.xml"));
        conf.addResource(new Path(HADOOP_HOME, "etc/hadoop/mapred-site.xml"));
        conf.addResource(new Path(HADOOP_HOME, "etc/hadoop/yarn-site.xml"));
        println conf.toString()
        println conf.getRaw("fs.default.name")
        fileSystem = FileSystem.get(conf);
        println fileSystem.toString();        
    }


    def readPath(path, chunk = 0){
        def builder = new StringBuilder();
        def thePath = new Path(path);

        def bufferedReader = new BufferedReader(new InputStreamReader(fileSystem.open(thePath)));
        def charsToRead = 16 * 1024;
        char[] cBuff = new char[charsToRead] // (16k chars)
        int foffset = 0 * charsToRead;
        int boffset = 0
        int charsRead = bufferedReader.read(cBuff, foffset, charsToRead)
        while (charsRead != -1 && charsToRead > 0) {
            builder.append(cBuff, boffset, charsRead);
            boffset += charsRead;
            foffset += charsRead;
            charsToRead -= charsRead;
            charsRead = bufferedReader.read(cBuff, foffset, charsToRead)
        }
        return builder.toString();
    }

    def readPathAsTsv(path, chunk = 0) {
        def json = []
        def thePath = new Path(path);

        def bufferedReader = new BufferedReader(new InputStreamReader(fileSystem.open(thePath)));
        def csv = bufferedReader.toCsvReader([separatorChar: '\t'])
        while (json.size() < 256) {
            def tokens = csv.readNext();
            json << tokens
        }
        return json
    }

}
