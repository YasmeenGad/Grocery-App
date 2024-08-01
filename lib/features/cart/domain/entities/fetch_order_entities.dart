import 'package:equatable/equatable.dart';

class FetchedOrder extends Equatable {
  final String id;
  final UserCart user;
  final List<ProductCart> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  FetchedOrder({
    required this.id,
    required this.user,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });
  
  @override
  List<Object?> get props => [id, user, products, createdAt, updatedAt];
}

class UserCart extends Equatable {
  final String userName;
  final String email;

  UserCart({
    required this.userName,
    required this.email,
  });
  
  @override
  List<Object?> get props => [userName, email];
}

class ProductCart extends Equatable {
  final String productName;
  final bool bestSelling;
  final double price;
  final int quantity;
  final String productDetail;
  final double rate;
  final String categoryName;
  final String photo;

  ProductCart({
    required this.productName,
    required this.bestSelling,
    required this.price,
    required this.quantity,
    required this.productDetail,
    required this.rate,
    required this.categoryName,
    required this.photo,
  });
  
  @override
  List<Object?> get props => [productName, bestSelling, price, quantity, productDetail, rate, categoryName, photo];
}
