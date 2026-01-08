class CartViewModel {
  int? id;
  int? productId;
  String? name;
  String? price;
  int? quantity;
  String? image;

  CartViewModel(
      {this.id,
        this.productId,
        this.name,
        this.price,
        this.quantity,
        this.image});

  CartViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
  }


}
