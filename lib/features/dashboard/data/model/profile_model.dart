class ProfileModel {
  String? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? password;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  ProfileModel(
      {this.id,
        this.name,
        this.email,
        this.mobileNumber,
        this.password,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    password = json['password'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
