int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  // speed = d/t
  //d = wordCount
  //t is from google that avarage human reading speed is 225 to 300 words per minute
  final readingTime = wordCount / 225;
  return readingTime.ceil();
}
