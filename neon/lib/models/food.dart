class Food {
    String imageUrl;
    String name;
   double price;

  Food(
    this.imageUrl,
    this.name,
    this.price
  );
  @override
  String toString() {

    //return super.toString();
    return (this.name + ""+this.price.toString());
  }
}