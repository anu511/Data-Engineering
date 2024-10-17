// In scala programming switch is referred as Match case

object MatchCase{
  def main(args:Array[String]): Unit = {
    def dayOfWeek(day: Int): String = day match {
      case 1 => "Monday"
      case 2 => "Tuesday"
      case 3 => "Wednesday"
      case 4 => "Thursday"
      case 5 => "Friday"
      case 6 => "Saturday"
      case 7 => "Sunday"
      case _ => "Invalid Day"
    }

    def StringMatch(Input: String): String = Input match {
      case "Vivek" => "Hello Vivek"
      case "Elias" => "Good Afternoon Elias"
      case "Vismaya" => "Good Evening"
      case _ => "Hello Strangers"
    }

    println(dayOfWeek(4))
    println(dayOfWeek(8))
    
    println(StringMatch("Vivek"))
    println(StringMatch("Elias"))
    println(StringMatch("Sarath"))
  }
}

