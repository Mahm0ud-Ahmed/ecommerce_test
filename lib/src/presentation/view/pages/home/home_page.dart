import 'package:ecommerce_test/src/presentation/view/common/product_item_widget.dart';
import 'package:ecommerce_test/src/presentation/view/common/preview_grid.dart';
import 'package:ecommerce_test/src/presentation/view/common/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_test/src/core/utils/api_info.dart';
import 'package:ecommerce_test/src/core/utils/layout/responsive_layout.dart';
import 'package:ecommerce_test/src/presentation/view_model/blocs/data_bloc/api_data_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/l10n/generated/l10n.dart';
import '../../../../core/utils/enums.dart';
import '../../../../data/models/product_model.dart';
import '../../../view_model/blocs/data_bloc/api_data_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final ApiDataBloc<ProductModel> productBloc;

  @override
  void initState() {
    super.initState();
    productBloc = ApiDataBloc<ProductModel>();
    productBloc.getIndexData(info: ApiInfo(endpoint: ApiRoute.product.route));
  }

  @override
  void dispose() {
    productBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      titleAppBar: S.of(context).app_name,
      showAppBarActions: true,
      builder: (context, info) {
        return RefreshIndicator(
          onRefresh: () async => productBloc.getIndexData(info: ApiInfo(endpoint: ApiRoute.product.route)),
          child: BlocBuilder<ApiDataBloc<ProductModel>, ApiDataState<ProductModel>>(
            bloc: productBloc,
            builder: (context, state) {
              return state.maybeMap(
                success: (value) {
                  return PreviewGrid<ProductModel>(
                    data: value.response,
                    builder: (BuildContext context, int index) {
                      return ProductItemWidget(product: value.response[index]);
                    },
                  );
                },
                error: (value) {
                  return TextWidget(text: value.error?.statusMessage ?? '');
                },
                orElse: () => Center(child: const CircularProgressIndicator()),
              );
            },
          ),
        );
      },
    );
  }
}
