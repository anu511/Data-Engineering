object DataStructures{
  def main(args:Array[String]):Unit ={
    //Collection of Datatypes
    //In Scala, a list is an immutable,heterogeneous,ordered sequence of elements
    //Lists are fundamental part of scala programming

    //empty list declaration
    val emptyList: List[Nothing] = List()
    val value = List()

    val valList:List[String] = List("Apricot","Blueberry","Cherry","Donuts","Eclairs")
    println(valList)
    valList.foreach(println)

    //Methods of List
    val firstValue = valList.head
    val restOfList = valList.tail
    val lastValue = valList.last
    val secondVal = valList(1)
    val length = valList.length

    //Print all values
    println("Display First Value: "+firstValue)
    println("Display Rest of the  Values: "+restOfList)
    println("Display Last Value: "+lastValue)
    println("Display Second Value: "+secondVal)
    println("Display Length of List: "+length)

    //valList = valList :+ "Fig" - Append in existing list is not possible due to immutability
    val appendList = valList :+ "Fig"
    println("Is valList Empty? "+valList.isEmpty)

    val newValList = List("Fig","Grapes","HazelNut")

    //Concatenation of List
    val fruitBasket = valList ++ newValList
    println(fruitBasket)

    //Transformation of List
    val list_1 = List(1,2,3,4,5,6,7,8,9,10)
    println(list_1.map(_*2))
    val evenNum = list_1.filter(_%2==0)
    println("Even Numbers: "+evenNum)

    val nestedList = List(List("Delhi","Kochi","Bengaluru","Kolkata"),
                          List("Pune","Mumbai","Varkala","Delhi"),
                          List("Trivandrum","Kolkata","Visakhapatanam","Kottayam"))

    println(nestedList)
    //identity is predefined function 'A=>A' A maps to A
    println(nestedList.flatMap(identity))

    println(list_1.filter(_%2==0).reduce(_+_))  // _ represents an element

    println(nestedList.flatten)

    //Returns list of Characters if length from input List
    println(fruitBasket.map(_.length))
    //Returns boolean value of string starts with string "A"
    println(fruitBasket.map(_.startsWith("A")))

    //Sort the list by Word Length
    val sortedList = fruitBasket.sortWith(_.length < _.length)
    println("Sorted List: "+sortedList)

    val sortedCity = nestedList.flatten.sortBy(_.length)
    println("Sorted City: "+sortedCity)

    //Display the list of city that starts with letter "K"
    println(nestedList.flatten.filter(_.startsWith("K")))
    //Alternative Method
    println(nestedList.flatten.filter(_.head == 'K'))

    //Subset and Slicing
    val city = nestedList.flatten
    println(city.take(5))
    println(city.takeRight(2))
    println(city.drop(2))
    println(city.dropRight(2))

    //Slicing the List Using start index and last index position
    println(city.slice(1,6))
    //slicing using random index position(0,2,4,5,7,9)
    val indices = List(0,2,4,5,7,9)
    //lift() : It is a method that retrieves an element at specified index
    println(indices.flatMap(index =>city.lift(index)))
    val populations = List(31000000,600000, 12000000, 14000000, 7000000, 20000000, 30000, 1000000)
    val pairedList = city.zip(populations)
    println(pairedList)

    //Array:Mutable Collection, indexed with sequence of elements starts from 0
    //It provides fast access and modifications of elements ,making them useful for performance
    //critical applications
    //Arrays are of fixed size
    println()
    val emptyArray = Array[Int]()
    val array1 = Array(1,2,3,4,5)

    //Accessing Individual value using index
    val firstElement = array1(0)
    val secondElement = array1(1)

    //update the existing value
    array1(0) = 10

    //Getting length of array
    println("Length: "+array1.length)

    //Adding or Removing values from an Array
    //array1 += 7
    //array1 -= 3
    import scala.collection.mutable.ArrayBuffer
    val arrayBuffer = ArrayBuffer(1,2,3,4,5,6,7,8,9,10)
    arrayBuffer +=11
    arrayBuffer -=1
    val newArray = arrayBuffer.toArray
    newArray.foreach(println)
    println(newArray)

    val Array2 = ArrayBuffer(array1:_*)
    println(Array2)
    Array2.foreach(println)
    //Apply mkString to Collections of Array,Lists etc
    println(Array2.mkString(", "))

    //Transformation of Arrays
    //Map
    println(Array2.map(_*3).mkString(", "))
    //Filter
    println(Array2.filter(_>3).mkString(", "))

    val Array3 = Array(Array(1,2,3,4),Array(5,6,7,8),Array(9,10,11))
    Array3.flatten.foreach(println)

    //Slicing and Substring
    println(newArray.take(5).mkString(", "))
    println(newArray.takeRight(2).mkString(", "))
    println(newArray.dropRight(5).mkString(", "))
    newArray.drop(1).foreach(println)

    //Reverse the array
    println(newArray.reverse.mkString(", "))

    //Sorting an Array
    val unsorted = Array(200,12,345,873,123,349,193)
    println(unsorted.sorted.mkString(", "))


  }
}
