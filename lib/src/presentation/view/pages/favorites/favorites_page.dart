import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecommerce_test/src/core/utils/constant.dart';
import 'package:ecommerce_test/src/core/utils/extension.dart';
import 'package:ecommerce_test/src/core/utils/layout/responsive_layout.dart';
import 'package:ecommerce_test/src/data/models/product_model.dart';
import 'package:ecommerce_test/src/presentation/view/common/product_item_widget.dart';
import 'package:ecommerce_test/src/presentation/view/common/text_widget.dart';

import '../../../../core/config/l10n/generated/l10n.dart';
import '../../../../core/utils/enums.dart';
import '../../../view_model/blocs/local_bloc/local_data_bloc.dart';
import '../../../view_model/blocs/local_bloc/local_data_state.dart';
import '../../common/preview_grid.dart';
import '../product_details/product_details_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final LocalDataBloc localDataBloc;

  @override
  void initState() {
    super.initState();
    localDataBloc = LocalDataBloc();
    localDataBloc.getLocalData();
  }

  @override
  void dispose() {
    localDataBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      titleAppBar: S.of(context).favorites_page_app_bar_title,
      builder: (context, info) {
        return BlocBuilder<LocalDataBloc, LocalDataState>(
          bloc: localDataBloc,
          builder: (context, state) {
            return state.maybeMap(
              loading: (value) => const Center(child: CircularProgressIndicator()),
              success: (value) {
                if (value.data.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.solidStar, size: kIconLargeSize, color: ThemeColor.warningColor.color),
                      (context.sizeSide.smallSide * .08).h,
                      TextWidget(
                        text: S.of(context).favorites_page_empty_title,
                        style: context.bodyL,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }
                return PreviewGrid<ProductModel>(
                  data: value.data,
                  builder: (BuildContext context, int index) {
                    return ProductItemWidget(
                      product: value.data[index],
                      onTap: () => pushProductDetailsPage(context, value.data[index]),
                    );
                  },
                );
              },
              error: (value) => Center(child: TextWidget(text: value.error?.statusMessage ?? '')),
              orElse: () => const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }

  void pushProductDetailsPage(BuildContext context, ProductModel product) {
    context.push(ProductDetailsPage(product: product)).then((value) {
      final bool result = localDataBloc.dataIsExist(product.id).data as bool;
      if (!result) {
        localDataBloc.getLocalData();
      }
    });
  }
}
