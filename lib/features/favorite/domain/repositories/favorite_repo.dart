import 'package:dartz/dartz.dart';
import 'package:supermarket/features/favorite/domain/entities/add_favorite.dart';

abstract class FavoriteRepository {
  Future<Either<String, AddFavorite>> addFavoriteProducts(List<String> productIds);
}