import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Home/data/models/best_selling_products_model.dart';
import 'package:supermarket/features/Home/domain/usecases/get_all_products_usecase.dart';

part 'best_selling_products_event.dart';
part 'best_selling_products_state.dart';

class BestSellingProductsBloc extends Bloc<BestSellingProductsEvent, BestSellingProductsState> {

  final  GetProductsUseCase getProductsUseCase;
  BestSellingProductsBloc({required this.getProductsUseCase}) : super(BestSellingProductsInitial()) {
    on<GetBestSellingProducts>(_onGetBestSellingProducts);
  }

   Future<void> _onGetBestSellingProducts(GetBestSellingProducts event, Emitter<BestSellingProductsState> emit) async {
    emit(BestSellingProductsInitial());
    final result = await getProductsUseCase.getBestSellingProducts();

    result.fold(
      (failure) => emit(BestSellingProductsError(failure.toString())),
      (products) => emit(BestSellingProductsLoaded(products)),
    );
  }
}
