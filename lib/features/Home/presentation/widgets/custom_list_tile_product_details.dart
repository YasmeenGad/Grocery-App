import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/favorite/presentation/bloc/add_faorite_bloc/add_favorite_bloc.dart';

class CustomListTileProductDetails extends StatelessWidget {
  const CustomListTileProductDetails(
      {super.key, required this.productName, required this.productDetails, required this.productId});
  final String productName;
  final String productDetails;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  "${productName}",
                  style: AppStyles.styleBold24(context)
                      .copyWith(color: blackColor),
                )),
            subtitle: Text(
              "${productDetails}, Price",
              maxLines: 2,
              style: AppStyles.styleMedium16(context)
                  .copyWith(color: secondaryColor),
            ),
            trailing: GestureDetector(
              onTap: () {
                // Dispatch the event to add product to favorites
                context
                    .read<AddFavoriteBloc>()
                    .add(AddFavorite( [productId]));
              },
              child: Icon(
                Icons.favorite_outline,
                color: darkColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
