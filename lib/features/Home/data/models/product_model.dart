import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required   String id,
    required String productName,
    required double price,
    required int stock,
    required int quantity,
    required String productDetail,
    required double rate,
    required String createdAt,
    required String updatedAt,
    required String photo,
    required String categoryName,
    required bool bestSelling,
  }) : super(
          id: id,
          productName: productName,
          price: price,
          stock: stock,
          quantity: quantity,
          productDetail: productDetail,
          rate: rate,
          createdAt: createdAt,
          updatedAt: updatedAt,
          photo: photo,
          categoryName: categoryName,
          bestSelling: bestSelling,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id']?? '',
      productName: json['productName']?? '',
      price: json['price'].toDouble()?? '',
      stock: json['stock']?? '',
      quantity: json['quantity']?? '',
      productDetail: json['productDetail']?? '',
      rate: json['rate'].toDouble()?? '',
      createdAt: json['createdAt']?? '',
      updatedAt: json['updatedAt']?? '',
      photo: json['photo']?? '',
      categoryName: json['categoryName']?? '',
      bestSelling: json['bestSelling'] == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': productName,
      'price': price,
      'stock': stock,
      'quantity': quantity,
      'productDetail': productDetail,
      'rate': rate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'photo': photo,
      'categoryName': categoryName,
      'bestSelling': bestSelling.toString(),
    };
  }
  

  @override
  String toString() {
    return 'ProductModel(productName: $productName, price: $price, stock: $stock, quantity: $quantity, productDetail: $productDetail, rate: $rate, createdAt: $createdAt, updatedAt: $updatedAt, photo: $photo, categoryName: $categoryName, bestSelling: $bestSelling)';
  }

  
}
