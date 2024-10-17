object MatchCalculator{
  def main(args: Array[String]):Unit = {
    def calculator(num1:Int,num2:Int,op:String):Any =op match{
      case "+" => num1+num2
      case "-" => num1-num2
      case "*" => num1*num2
      case "/" => if (num2==0) then "Division Not Possible" else num1/num2
      case "%" => num1%num2
      case "^" => math.pow(num1,num2)
      case _ => "Invalid operation"
    }
    
    println(calculator(2,3,"+"))
    println(calculator(5,6,"*"))
    println(calculator(2,0,"/"))
    println(calculator(2,2,"^"))
  }
}
