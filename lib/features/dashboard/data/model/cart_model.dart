class CartViewModel {
  int? id;
  int? productId;
  String? name;
  String? price;
  int? quantity;
  String? image;

  CartViewModel({this.id,
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

  CartViewModel copyWith({
    int? id,
    int? productId,
    String? name,
    String? price,
    int? quantity,
    String? image,
  }) {
    return CartViewModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
    );
  }
}