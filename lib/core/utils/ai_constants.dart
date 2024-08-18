class AiConstants {
  static String summarizePrompt(String summaryLength) {
    return """
Please give $summaryLength summary for the following content sourced from images.
Also add search for key information such as 
book title, 
author name, 
exact published date with year month and day (year-month-day), 
and three interesting facts on the internet.

Please make sure that you give the response in the following format:

{
  "title": "...",
  "summary": "...",
  "author": "...",
  "publishedDate": "...",
  "facts": ["...", "...", "..."] 
}

""";
  }
}
