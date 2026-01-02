class ProductModel {
  String? id;
  String? name;
  String? price;
  String? image;
  String? categoryId;
  String? status;
  String? createdAt;
  String? updatedAt;

  ProductModel(
      {this.id,
        this.name,
        this.price,
        this.image,
        this.categoryId,
        this.status,
        this.createdAt,
        this.updatedAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toString();
    image = json['image'];
    categoryId = json['category_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}