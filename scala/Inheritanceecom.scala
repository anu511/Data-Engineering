//Parent Class
class Ecommerce(val name:String,val quantity:Float,val price:Float){
  def displayDetails():Unit = {
    val tot=quantity*price
    println(f"Product Info Name: $name,Quantity: $quantity,Total Amount($tot)")
  }
}

//Inheritance - Electronics
class Electronics(name:String,quantity:Float,price:Float) extends Ecommerce(name,quantity,price) {
  override def displayDetails():Unit = {
    val tot=quantity*price
    println(f"Electronics \n Name: $name,Quantity: $quantity,Total Amount $tot")
  }
}

//Inheritance  - Books
class Books(name:String,quantity:Float,price:Float) extends Ecommerce(name,quantity,price) {
  override def displayDetails():Unit = {
    val tot=quantity*price
    println(f"Books\n Name: $name,Quantity: $quantity,Total Amount $tot")
  }
}

//Inheritance  - FootWear
class FootWear(name:String,quantity:Float,price:Float) extends Ecommerce(name,quantity,price) {
  override def displayDetails():Unit = {
    val tot=quantity*price
    println(f"FootWear\n Name: $name,Quantity: $quantity,Total Amount $tot")
  }
}

object example extends App{
  val item1 = new Electronics("Laptop",2,50000)
  item1.displayDetails()
  val item2=new Books("Harry Potter",5,1000)
  item2.displayDetails()
  val item3 = new FootWear("Shoe",3,2000)
  item3.displayDetails()
}



//Inheritance - Footwear
