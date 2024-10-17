import scala.io.Source
object FileAnalysis{
  def main(args:Array[String]):Unit = {
    //Read from file
    val source = Source.fromFile("C:/Users/Administrator/Downloads/sample.txt")

    //Read all values and create List of Lines
    val lines = source.getLines().toList  //returns a nested list
    println(lines)
    //Close the file object
    source.close()

    //Process the file data
    //Split lines into words, change words to its lowercase
    val words = lines.flatMap(_.split("\\s+").map(_.toLowerCase))
    println(words)

    //group words by identity
    //map values by its size
    //sort words in descending order using negated value(-_.2) 2 represents the second part(count)
    //Print top 10 most frequent words
    val wordCount = words.groupBy(identity).mapValues(_.size).toSeq.sortBy(-_._2)
    wordCount.take(10).foreach{ case (word,count)=> println(s"$word: $count")}

    //1.Find the count of words
    val len = words.length
    println((len))

    //2.Find the word with maximum length and minimum length
    val sortedWords = words.sortWith(_.length<_.length)
    println("Minimum Length: "+sortedWords.head)
    println("Maximum Length: "+sortedWords.last)







  }
}
