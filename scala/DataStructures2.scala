object DataStructures2{
  def main(args:Array[String]):Unit = {
    //MAP : Collection of key-value pairs
    //Map can mutable or immutable.By default, map is immutable
    val fruitBasket1 = Map("Apricot"->20,"Blueberry"->250,"Cherry"->100,"Donuts"->24,"Eclairs"->100)

    //Mutable Maps
    import scala.collection.mutable
    val mutableMap = mutable.Map("Apricot"->20,"Blueberry"->250,"Cherry"->100,"Donuts"->24,"Eclairs"->100)

    //Basic Operations
    val value = fruitBasket1("Donuts")
    println(value)
    println(fruitBasket1.contains("Donuts"))
    val mapSize = fruitBasket1.size
    println(mapSize)
    val keys = mutableMap.keys
    println(keys)
    val values = mutableMap.values
    println(values)

    //Adding and Removing Values
    mutableMap+=("Fig"->24)
    mutableMap-=("Eclairs")
    println(mutableMap)

    //Apply same on immutable
    val newFruitBasket = fruitBasket1 +("Fig"->24)

    println(newFruitBasket)
    mutableMap("Fig") =30
    println(mutableMap)

    val set1 = Set(1, 2, 3, 4, 5, 6, 7, 8)
    val set2 = Set("Apple", "Banana", "Cheery", "Grapes", "Tomato",
      "Oranges", "Watermelon", "Pineapple")

    // Basic Operations
    println(set1.contains(5))
    println(set1.size)
    println(set1 + 9)

    // Union of sets
    val set3 = Set("Grapes", "Tomato", "Guava", "Oranges", "Banana")
    val fruitBasket = set2 union set3
    println(fruitBasket)

    // Intersect : Common value between Two Sets.
    val interSet = set2 intersect set3

    // Difference
    val diffSet = set2 diff set3
    println(diffSet)

    val diffSet1 = set3 diff set2
    println(diffSet1)

    // subset check
    val isSubset = set2.subsetOf(set3)
    println(isSubset)

    // Transformation - map, filter, reduce
    println(set3.map(_.toLowerCase()).mkString(","))
    println(set1.map(_ * 2).mkString(","))
    println(set3.filter(_.startsWith("G")).mkString(","))

    // mutable Sets
    val set4 = mutable.Set(10, 20, 30, 40, 50, 60, 70)
    set4 += 10
    set4 ++= Set(80, 90)
    set4 --= Set(10, 20)

    // clear Sets
    set4.clear()

    // create a new collection
    val fruitList = List("apple", "apricot", "banana", "chocolate", "coconut")
    val mapFruits = fruitList.groupBy(_.head)

    //val variable name:datatype=value
    val newMapFruits: mutable.Map[Char,List[String]] = mutable.Map(mapFruits.toSeq: _*)
    println(newMapFruits.mkString(", "))

    //Concatenate new values to the mutable map
    newMapFruits ++= Map('d'->List("Dragon Fruit"),'e'->List("Eclairs"))
    println(newMapFruits.mkString(", "))

    //Tuple DataType
    //Collection of Immutable Datatype,Fixed Size,Heterogeneous
    //Index position starts from 1

    val tuple1 = (1,"Hello Tuple",3.14,"Scala",987654321L)
    println(tuple1(1))

    val firstValue = tuple1._1
    val secondValue = tuple1._2

    //Pattern Matching in Tuple
    val(var1,var2,var3) = (1,"Scala",3.14)
    println(var1)

    //Returns number of elements present in tuple
    println(tuple1.productArity)

    //Returns datatype of variable
    println(tuple1.getClass)

    //copy: Allows you to copy tuple with some elements replaced
    val newTuple = tuple1.copy(_4="Tuple")
    println(newTuple)

    //=>(arrow function)
    //In Scala =>is used to denote a lambda expression or anonymous value
    //(parameter)=>expression
    tuple1.productIterator.foreach{
      (element => println(s"Element: $element"))
    }
  }
}