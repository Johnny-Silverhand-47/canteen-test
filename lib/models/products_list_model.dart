class ProductsListModel {
  int? status;
  String? message;
  Products? products;

  ProductsListModel({this.status, this.message, this.products});

  ProductsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    products =
        json['products'] != null ? Products.fromJson(json['products']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (products != null) {
      data['products'] = products!.toJson();
    }
    return data;
  }
}

class Products {
  int? currentPage;
  List<ProductData>? productData;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Products(
      {this.currentPage,
      this.productData,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Products.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      productData = [];
      json['data'].forEach((v) {
        productData!.add(ProductData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (productData != null) {
      data['data'] = productData!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class ProductData {
  int? id;
  String? name;
  double? price;
  int? maxQty;
  int? available;
  List<ProductImages>? productImages;

  ProductData(
      {this.id,
      this.name,
      this.price,
      this.maxQty,
      this.available,
      this.productImages});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.tryParse(json['price'].toString())??0.0;
    maxQty = json['max_qty'];
    available = json['available'];
    if (json['product_images'] != null) {
      productImages = [];
      json['product_images'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['max_qty'] = maxQty;
    data['available'] = available;
    if (productImages != null) {
      data['product_images'] = productImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImages {
  int? id;
  int? productId;
  String? image;
  int? sequence;
  String? createdAt;
  String? updatedAt;

  ProductImages(
      {this.id,
      this.productId,
      this.image,
      this.sequence,
      this.createdAt,
      this.updatedAt});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
    sequence = json['sequence'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['image'] = image;
    data['sequence'] = sequence;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
