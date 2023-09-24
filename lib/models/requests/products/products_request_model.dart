import 'dart:convert';

ProductsRequestModel productsRequestModelFromJson(Map<String, dynamic> str) => ProductsRequestModel.fromJson(str);

String productsRequestModelToJson(ProductsRequestModel data) => json.encode(data.toJson());

class ProductsRequestModel {
    String? title;
    double? price;
    String? description;
    String? image;
    String? category;

    ProductsRequestModel({
        this.title,
        this.price,
        this.description,
        this.image,
        this.category,
    });

    factory ProductsRequestModel.fromJson(Map<String, dynamic> json) => ProductsRequestModel(
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        image: json["image"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "description": description,
        "image": image,
        "category": category,
    };
}
