object Loops{
  def main(args:Array[String]): Unit={

    //Simple while loop syntax that prints numbers from 1 to 9
    var variable = 1
    while(variable<10){
      println(variable)
      variable +=1
    }

    //Do While not supported
    //For loop
    val fruits = List("apple","banana","cherry","dragon fruit","oranges")
    for (fruit <- fruits){
      println(fruit)
    }

    for(i<- 1 to 10){
      println(i)
    }

    //Loop with Step size 2
    for (i <- 1 to 10 by 2){
      println(i)
    }

    val foodList = List("idli","vada","dosa","uttapam","biriyani","chocolate","curd")
    for(food<-foodList){
      println(food)
    }

    //Filtering Records in For Loop using if condition
    //1. Write a scala program which creates a collection of even array
    import scala.collection.mutable.ArrayBuffer
    val arrayBuffer = ArrayBuffer[Int]()
    for(m<-1 to 20 if m%2==0){
      arrayBuffer+=m
    }
    println(arrayBuffer.mkString(", "))

    //2.Write a scala program to show collection of prime number between 1-100
    val primeNo = ArrayBuffer[Int]()

    for(i<-1 to 100){
      if(i>1) {
        var flag = 0
        for (j <- 2 to math.sqrt(i).toInt if (i % j == 0)) {
          flag = 1
        }
        if (flag == 0){
          primeNo += i
        }
      }
    }
    println(primeNo.mkString(", "))

    //3.Fibonacci series using while
    var fibSeries = ArrayBuffer[Int](0,1)
    var first=0
    var second = 1
    var third = 0
    while(first < 100){
      third= first+second
      fibSeries+=third
      first=second
      second=third
    }
    println(fibSeries.mkString(", "))

    //4.Find the first prime number greater than given number.Take user input
    import scala.io.StdIn._
    println("Enter a num")
    val num = readInt()
    var nextPrime=num+1
    var isPrime = false
    
    
    while(!isPrime){
      isPrime =true
      for(i<-2 to nextPrime/2 if isPrime){
        if(nextPrime%i==0){
          isPrime=false
        }
      }
      if(!isPrime){
        nextPrime+=1
      }
    }
    println(s"The Prime number after $num is $nextPrime")
    

  }
}
