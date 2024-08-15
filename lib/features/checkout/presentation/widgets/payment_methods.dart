import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/features/checkout/presentation/widgets/payment_method_item.dart';

class PaymentMethodsListView extends StatelessWidget {
  const PaymentMethodsListView({super.key});

  final List<String> paymentMethodsItems = const [
    Assets.imagesCard,
    Assets.imagesPaypal,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: paymentMethodsItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PaymentMethodItem(
              image: paymentMethodsItems[index],
              isActive: false,
            ),
          );
        },
      ),
    );
  }
}
