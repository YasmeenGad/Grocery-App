import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_quantity_icon.dart';

class QuantityCartSection extends StatelessWidget {
  const QuantityCartSection({super.key, required this.quantity});
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomQuantityIcon(
          icon: Icons.remove,
          iconColor: Color(0xffB3B3B3),
        ),
        const SizedBox(width: 6),
        Text('${quantity}'),
        const SizedBox(width: 6),
        CustomQuantityIcon(
          icon: Icons.add,
          iconColor: primaryColor,
        ),
      ],
    );
  }
}
