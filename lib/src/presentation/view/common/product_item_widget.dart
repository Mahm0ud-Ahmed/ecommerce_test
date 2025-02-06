import 'package:ecommerce_test/src/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecommerce_test/src/core/utils/constant.dart';
import 'package:ecommerce_test/src/core/utils/extension.dart';
import 'package:ecommerce_test/src/data/models/product_model.dart';
import 'package:ecommerce_test/src/presentation/view/common/image_widget.dart';
import 'package:ecommerce_test/src/presentation/view/common/text_widget.dart';

import '../pages/product_details/product_details_page.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  const ProductItemWidget({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kMidNumber)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: ThemeColor.secondary.color,
          onTap: () {
            if (onTap != null) {
              onTap!.call();
            } else {
              context.push(ProductDetailsPage(product: product));
            }
          },
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageWidget(
                    image: product.image,
                    width: constraints.maxWidth * .25,
                    height: constraints.maxHeight,
                    fit: BoxFit.contain,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(kMidNumber), bottomStart: Radius.circular(kMidNumber)),
                    ),
                    imageBuilder: (context, image) => ClipRRect(
                      borderRadius: BorderRadius.circular(kMidNumber),
                      child: image,
                    ),
                  ),
                  (constraints.maxWidth * .02).w,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: TextWidget(
                            text: product.title,
                            lines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyM?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Flexible(
                                child: TextWidget(
                                  text: product.price.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: context.labelL?.copyWith(color: ThemeColor.textSecondary.color),
                                ),
                              ),
                              (constraints.maxWidth * .01).w,
                              Icon(FontAwesomeIcons.dollarSign, size: 14, color: ThemeColor.successColor.color),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
