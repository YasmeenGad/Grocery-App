import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/favorite/data/models/favorite_data_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<FavoriteModel> addFavoriteProducts(List<String> productIds);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  FavoritesRemoteDataSourceImpl({
    required this.authLocalDataSource,
    required this.client,
  });

  @override
  Future<FavoriteModel> addFavoriteProducts(List<String> productIds) async {
    final token = await authLocalDataSource.getCachedLoginResponse();
    final cachedToken = token?.token ?? '';

    final url = Uri.parse('http://$ip:4000/favorite/add');
    final response = await client.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $cachedToken',
      },
      body: json.encode({'products': productIds}),
    );
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      return FavoriteModel.fromJson(decodedJson);
    } else {
      throw Exception('Failed to add favorite products: ${response.body}');
    }
  }
}
