//Case Classes are special classes in scala that are used for modeling immutable data strictures
//and compared by value.
//They are ideally used in pattern matching
//Case classes will automatically provide some useful methods like:
//toString,equals,hashCode ,built in support for pattern matching

//Case class are immutable
object CaseClass{
  def main(args:Array[String]): Unit = {
    //Define a case class
    case class Employee(name: String, age: Int)
    //Create an instance (object) of case class
    val obj = Employee("Melissa", 20)

    //Access Fields
    println(obj.age)
    println(obj.name)

    //Pattern matching
    obj match {
      case Employee(name, age) => println(s"Name: $name, Age: $age")
    }

    //Create a copy with modified fields
    val olderObj = obj.copy(name = "Anu")
    println(olderObj)
  }
}




/*case class Person(name:String,age:Int)
//Main Object
object Main extends App{
  //Create object of case class
  val person = Person("Tom",20)

  //Define a function to describe a Person
  def describePerson(person:Any):String = person match{
    case Person(name,age) =>s"Person Name: $name,Age: $age"
}
  //Test Functionality
  println(describePerson((person)))
}
*/



 
/*{
  object CaseClass extends App{
    //Create an instance of case class
    val person1 = Person("Tom",10)
    val person2 = Person("Jerry",4)
    println(person1)
    println(person2)

    //Copy a case class
    val person3 = person1.copy(age = 20)
    println(person3)

    //Pattern matching with case class
    person1 match{
      case Person(name,age) =>println(s"Name: $name, Age: $age")
    }
  }
}*/