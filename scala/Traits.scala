//Traits
//A trait is a special type of class used to define a collection of methods and fields names that 
//can be reused across different classes.

//Traits Usage: Code Reusability in scala,Instead of duplicating code in multiple classes
// you can define common functionalities in a trait then mix it with any class.

//Scala does not support multiple inheritance(a class inherited from more than one class)
//But traits helps you to achieve this. A class can extend one class and mix it in multiple traits.

trait Drivable{
  def drive():Unit
}

trait Flyable{
  def fly():Unit = {
    println("Flying in the sky")
  }
}

class car(val make:String,val model:String) extends Drivable{
  override def drive():Unit = {
    println(s"Driving a $make of $model")
  }
}

class airplane(val make:String,val model:String) extends Flyable with Drivable {
  override def drive():Unit = {
    println(s"Taxiing on the runway")
  }

  override def fly(): Unit = {
    println(s"Airplane is Flying at 30000 Ft")
  }
}


