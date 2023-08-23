class UserData {
  UserData._privateConstructor();
  factory UserData() {
    return _instance;
  }
  static final UserData _instance = UserData._privateConstructor();
  UserModel userModel = UserModel();
}

class UserModel {
  int? status;
  String? message;
  String? token;
  User? user;

  UserModel({this.status, this.message, this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? address;
  String? contactNumber;
  int? isRegistered;
  int? storeId;
  String? type;
  String? username;
  String? priceType;

  User(
      {this.id,
      this.name,
      this.address,
      this.contactNumber,
      this.isRegistered,
      this.storeId,
      this.type,
      this.username,
      this.priceType});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    contactNumber = json['contact_number'];
    isRegistered = json['is_registered'];
    storeId = json['store_id'];
    type = json['type'];
    username = json['username'];
    priceType = json['price_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['contact_number'] = contactNumber;
    data['is_registered'] = isRegistered;
    data['store_id'] = storeId;
    data['type'] = type;
    data['username'] = username;
    data['price_type'] = priceType;
    return data;
  }
}
