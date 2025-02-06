import 'package:ecommerce_test/src/core/services/setting_service.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_test/src/core/config/injector.dart';
import 'package:ecommerce_test/src/core/utils/layout/responsive_layout.dart';

import '../../../../data/models/product_model.dart';
import 'widgets/body_product_details.dart';
import 'widgets/header_product_details.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    injector<SettingService>().theme.setPortraitMode();
  }

  @override
  void dispose() {
    injector<SettingService>().theme.defaultOrientationMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      showAppBar: false,
      isPadding: false,
      builder: (context, info) {
        return CustomScrollView(
          slivers: [
            HeaderProductDetails(product: widget.product),
            BodyProductDetails(product: widget.product),
          ],
        );
      },
    );
  }
}
