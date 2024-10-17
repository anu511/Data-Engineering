object Conditional{
  def main(args:Array[String]):Unit={
    //if else condition
    val x=10
    if (x>5){
      println(s"$x is greater than 5")
    } else{
      println((s"$x is less than 5"))
    }

    //if-else as an expression
    val y=3
    val result = if (y%2==0) "Even" else "Odd"
    println(result)

    //Ask user to input the data
    import scala.io.StdIn._
    println("Please Enter a value: ")
    //Read User Input and convert to integer
    val value = readInt()
    val result1 = if (y%2==0) "Even" else "Odd"
    println(s"$value is $result1")

    //Input marks and return a grade
    println("Enter your marks")
    val marks = readInt()
    var grade = 'P'
    if( marks>90){
      grade='A'
    }else if(marks>80){
      grade ='B'
    }else if(marks>70){
      grade ='C'
    }else if(marks>60){
    grade ='D'
    }else if(marks >50) {
      grade = 'E'
    }else{
      grade = 'F'
    }

    println(s"Your Grade is $grade")

    var grade2 = if(marks>90) 'A' else if(marks>80) 'B' else if(marks>70) 'C'
                else if(marks>60) 'D' else if(marks>50) 'E' else 'F'

    println(s"Your Grade is $grade2")




  }
}
