class Car(val make:String,val model:String,var year:Int){
  def displayInfo():Unit = {
        println(s"Car Info: $year $make $model")
      }
    }

//Create an object of class car
//Singleton Object extends app (trait) which does not need main() anymore
object SimpleClass extends App{
  private val car = new Car("Hyundai","Creta",2023)
  car.displayInfo()

  car.year = 2024
  car.displayInfo()
  }

