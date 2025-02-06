import 'package:flutter/material.dart';
import 'package:ecommerce_test/src/core/utils/extension.dart';
import 'package:ecommerce_test/src/presentation/view/pages/product_details/widgets/section_info.dart';

import '../../../../../core/config/l10n/generated/l10n.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../data/models/product_model.dart';
import '../../../common/custom_padding.dart';
import '../../../common/text_widget.dart';
import 'product_info.dart';

class BodyProductDetails extends StatelessWidget {
  final ProductModel product;
  const BodyProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: DecoratedBox(
        decoration: BoxDecoration(color: ThemeColor.cardPrimary.color.withValues(alpha: .3)),
        child: CustomPadding(
          top: context.sizeSide.width * (context.orientationInfo.isPortrait ? 0.03 : 0.01),
          start: context.sizeSide.width * 0.03,
          end: context.sizeSide.width * 0.03,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductInfo(product: product),
                (context.sizeSide.smallSide * .02).h,
                SectionInfo(
                  sectionTitle: S.of(context).product_details_page_description_section_title,
                  sectionInfo: TextWidget(
                    text: product.description,
                    style: context.bodyM?.copyWith(color: ThemeColor.textSecondary.color, height: 1.8, fontWeight: FontWeight.normal),
                  ),
                ),
                (context.sizeSide.smallSide * .04).h,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
