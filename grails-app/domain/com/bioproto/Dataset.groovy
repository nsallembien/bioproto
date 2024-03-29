package com.bioproto

class Dataset {

    static transient HdfsReader hdfsReader = new HdfsReader();

    String name;
    String status;
    String output;

    String hdfsOutputPath;
    boolean parsed;

    static belongsTo = [owner: User]

    static constraints = {
        output(nullable: true)
        hdfsOutputPath(nullable: true)
    }

    static mapping = {
        output type: "text"
    }

    def formattedChunk(chunk = 0) {
        if (output == null) {
            return hdfsReader.readPathAsTsv(hdfsOutputPath, chunk)
        } else {
            def json = []

            def bufferedReader = new StringReader(output);
            def csv = bufferedReader.toCsvReader([separatorChar: '\t'])
            def tokens = null
            while (json.size() < 10000 && (tokens = csv.readNext()) != null) {
                json << tokens
            }
            return json
        }
    }

    def htmlOutput(chunk = 0) {

        String logOutput = (output == null) ? hdfsReader.readPath(hdfsOutputPath, chunk) : output;
        def builder = new StringBuilder();
        def previousWasASpace = false;
        def previousWasACR = false;
        for (char c : logOutput.toCharArray()) {
            if (c == ' ') {
                if (previousWasASpace) {
                    builder.append("&nbsp;");
                    previousWasASpace = false;
                    continue;
                }
                previousWasASpace = true;
            } else {
                previousWasASpace = false;
            }
            switch (c) {
                case '<':
                    builder.append("&lt;");
                    break;
                case '>':
                    builder.append("&gt;");
                    break;
                case '&':
                    builder.append("&amp;");
                    break;
                case '"':
                    builder.append("&quot;");
                    break;
                case '\r':
                    if (!previousWasACR) {
                        builder.append("<br>");
                        previousWasACR = true;
                    } else {
                        previousWasACR = false;
                    }
                    break;
                case '\n':
                    if (!previousWasACR) {
                        builder.append("<br>");
                        previousWasACR = true;
                    } else {
                        previousWasACR = false;
                    }
                    break;
                // We need Tab support here, because we print StackTraces as HTML
                case '\t':
                    builder.append("&nbsp; &nbsp; &nbsp;");
                    break;
                default:
                    builder.append(c);

            }
        }
        def converted = builder.toString();
        def pattern = "(?i)\\b((?:https?://|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\)|[^\\s`!()\\[\\]{};:\'\".,<>?«»“”‘’]))";
        def matcher = converted =~ pattern
        converted = matcher.replaceAll('<a href="$1">$1</a>');
        return converted;
    }
}
