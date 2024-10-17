// SCALA - Scalable Language (OOPS + Functional Prog)

/*Functional Programming
Functional Programming is a programming paradigm where computation is treated as evaluation,
of mathematical functions.
It follows immutability.
It avoids changing in state or mutable data.
Functions are treated as First Class Citizen (First Class Functions),functions can be
passed as arguments to functions, return as values from another functions and can be assigned
to variables */

/*
Pure Functions
Functions should be pure
Some input -->Function-->Output

Val - Immutable
Var - Mutable

*OOPS

*Statically Typed

*Runs on JVM

*Processes Concurrently

Scala->JVM->ByteCode->Spark

Unit=void (no value)
*/

object DataTypes{
  def main(args:Array[String]):Unit = {
    //Primitive Data Types
    //Numeric Types
    val intVal: Int = 25
    val doubleVal: Double = 23.37478549
    val longVal: Long = 2347894279L
    var floatVal: Float = 45.23F

    //Character and String Types
    var charVal: Char = 'A'
    val message: String = "Hello Scala"

    //Byte
    var byteVal: Byte = 127

    //Boolean
    val boolVal: Boolean = true
    println("Integer Value:"+ intVal)
    println("Double Value: "+ doubleVal)
    println("Long Value: "+ longVal)
    println("String DataType: "+ message)
    println("Boolean DataType: "+ boolVal)


    //Reinitializing Value
    charVal = 'B'
    //intVal = 10  cannot reassign as it is val
    println("Character New Value: "+ charVal)

  }

}


