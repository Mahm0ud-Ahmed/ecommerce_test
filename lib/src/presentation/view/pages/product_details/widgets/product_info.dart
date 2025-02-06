import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecommerce_test/src/core/utils/extension.dart';
import 'package:ecommerce_test/src/presentation/view/pages/product_details/widgets/info_with_icon.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../data/models/product_model.dart';
import '../../../common/text_widget.dart';

class ProductInfo extends StatelessWidget {
  final ProductModel product;
  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextWidget(
                  text: product.title,
                  style: context.bodyM?.copyWith(fontWeight: FontWeight.bold, color: ThemeColor.textPrimary.color),
                ),
              ),
              (context.sizeSide.smallSide * .02).w,
              Row(
                children: [
                  TextWidget(
                    text: product.price.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyL?.copyWith(color: ThemeColor.textSecondary.color),
                  ),
                  Icon(FontAwesomeIcons.dollarSign, size: 14, color: ThemeColor.successColor.color),
                ],
              ),
            ],
          ),
          (context.sizeSide.smallSide * .02).h,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoWithIcon(
                icon: FontAwesomeIcons.solidStar,
                iconColor: ThemeColor.warningColor.color,
                info: '${product.rating.rate} / ${product.rating.count}',
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: ThemeColor.secondary.color,
                  borderRadius: BorderRadius.circular(kLargeNumber),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kSmallNumber * 1.5),
                  child: TextWidget(
                    text: product.category,
                    style: context.labelL,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
