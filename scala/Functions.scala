object Functions{
  def main(args: Array[String]): Unit = {
    //Function: Block of code which must do a certain task and

    //1.Create a function which takes users name as input and print greetings
    //Declare a Function: UDF(User Defined Function)
      import scala.io.StdIn.readLine
    //
    //    //Function takes one parameter
    //    def greetings(name:String):Unit = {
    //      println(s"Hello $name, Welcome to UST")
    //    }
    //
    //    println("Please enter your username: ")
    //    val username =readLine()
    //
    //    //Call a function with user's input
    //    greetings(username)
    //
    //    //2.Create a basic function which takes more than one parameter
    //    import scala.io.StdIn.readInt
    //    println("Enter two numbers")
    //    var a =readInt()
    //    var b =readInt()
    //    //Declare a function
    //    def add(a:Int,b:Int):Int = {
    //      a+b
    //    }
    //
    //    //Call a function
    //    var result = add(a,b)
    //    println(result)
    //
    //    //Alternative method
//    val p = readLine("Enter first value: ").toInt
//    val q = readLine("Enter second value: ").toInt
//
//    //Declare a function
//    def addition(a: Int, b: Int): Int = {
//      a + b
//    }
//
//    //Call a function
//    println(addition(p, q))
//
//    //3.Calculator: Create a scala function calculator
//    def calculator(a:Int,b:Int,op:String):Any={
//      if(op=="+"){
//        return a+b
//      }else if(op=="-"){
//        return a-b
//      }else if(op=="*"){
//       return a*b
//      }else if(op=="/"){
//        return a/b
//      }
//    }
//
//    val num1 =readLine("Enter First Value: ").toInt
//    val num2 =readLine("Enter Second Value: ").toInt
//    var op =readLine("Enter Operation: ")
//    println(calculator(num1,num2,op))

    //4.Declare a function with default value
//    def divide(a:Float,b:Float = 1):Float = {
//      return a/b
//    }
//
//    println(divide(p,q))
//    println(divide(p))

    //5.Lambda Function or Anonymous Function
//    val add = (a:Int,b:Int)=>a+b
//    println(add(p,q))
//
//    //6.Higher Order Function: Function that takes another function as a  parameter
//    def applyFunction(f:(Int,Int) =>Int,value1:Int,value2:Int):Int= {
//      f(value1,value2)
//    }
//
//    println(applyFunction(add,p,q))

    //6.Write a function that takes list as an input and returns a list without
    //any duplicate entries
//    def duplicates(l1:List[String]):List[String] ={
//      return l1.distinct
//    }
//    
//    val l1 = List("Apple","Banana","Cherry","Apple")
//    println(duplicates(l1))
//
//    //8.Check if a input is palindrome or not
//    def palindrome(str:String):Boolean ={
//      if(str==str.reverse){
//        return true
//      }else{
//        return false
//      }
//    }
//    
//    val str = readLine("Enter a string: ")
//    print(palindrome(str))
  //9.Create a Scala function which returns factorial of a number
  def factorial(n:Int):Int = {
    if(n==0) 1 //return 1
    else n * factorial(n-1)
  } 
    //Example Usage
    
    val number =readLine("Enter number: ").toInt
    println(factorial(number))
    
    




  }
}
