import 'dart:convert';

CartsRequestModel cartsRequestModelFromJson(Map<String, dynamic> str) => CartsRequestModel.fromJson(str);

String cartsRequestModelToJson(CartsRequestModel data) => json.encode(data.toJson());

class CartsRequestModel {
    int? userId;
    DateTime? date;
    List<Product>? products;

    CartsRequestModel({
        this.userId,
        this.date,
        this.products,
    });

    factory CartsRequestModel.fromJson(Map<String, dynamic> json) => CartsRequestModel(
        userId: json["userId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    };
}

class Product {
    int? productId;
    int? quantity;

    Product({
        this.productId,
        this.quantity,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
    };
}
