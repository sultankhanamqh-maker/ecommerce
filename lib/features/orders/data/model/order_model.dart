class OrderProductModel {
  int? id;
  String? name;
  int? quantity;
  String? price;
  String? image;

  OrderProductModel({
    this.id,
    this.name,
    this.quantity,
    this.price,
    this.image,
  });

  OrderProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    image = json['image'];
  }
}

class OrderModel {
  String? created_at;
  String? order_number;
  String? status;
  String? total_amount;
  int? id;
  List<OrderProductModel>? product;

  OrderModel({
    this.created_at,
    this.order_number,
    this.status,
    this.total_amount,
    this.id,
    this.product,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<OrderProductModel> products = [];
    for(Map<String,dynamic> eachProduct in json["product"]){
      products.add(OrderProductModel.fromJson(eachProduct));
    }
    return OrderModel(
        created_at: json["created_at"],
        order_number: json["order_number"],
        status: json["status"],
        total_amount: json["total_amount"],
        id: json["id"],
        product: products
    );
  }
}