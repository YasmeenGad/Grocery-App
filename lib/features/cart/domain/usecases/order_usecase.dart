import 'package:dartz/dartz.dart';
import 'package:supermarket/features/cart/domain/entities/create_order_entity.dart';
import 'package:supermarket/features/cart/domain/entities/fetch_order_entities.dart';
import 'package:supermarket/features/cart/domain/entities/get_total_order.dart';
import 'package:supermarket/features/cart/domain/repositories/order_repo.dart';

typedef OrderResult = Either<String, MyOrder>;
typedef FetchedOrderResult = Either<String, FetchedOrder>;
typedef TotalOrderResult = Either<String, TotalOrder>;

class OrderUsecases {
  final OrderRepository repository;

  OrderUsecases({required this.repository});

  Future<OrderResult> createOrder(List<String> productIds) async {
    return await repository.createOrder(productIds);
  }

  Future<FetchedOrderResult> getOrder() async {
    return await repository.getOrder();
  }

  Future<TotalOrderResult> calculateOrderTotals(String orderId) async {
    return await repository.calculateOrderTotals(orderId);
  }

  Future<OrderResult> updateOrder(String orderId, List<String> productIds) async {
    return await repository.updateOrder(orderId, productIds);
  }
}