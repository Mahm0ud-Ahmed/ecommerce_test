import 'package:ecommerce_test/src/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_test/src/core/utils/extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/config/l10n/generated/l10n.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../view_model/blocs/local_bloc/local_data_bloc.dart';
import '../../../../view_model/blocs/local_bloc/local_data_state.dart';
import '../../../common/image_widget.dart';
import '../../../common/text_widget.dart';

class HeaderProductDetails extends StatefulWidget {
  final ProductModel product;
  const HeaderProductDetails({super.key, required this.product});

  @override
  State<HeaderProductDetails> createState() => _HeaderProductDetailsState();
}

class _HeaderProductDetailsState extends State<HeaderProductDetails> {
  late final LocalDataBloc localDataBloc;
  @override
  void initState() {
    super.initState();
    localDataBloc = LocalDataBloc();
  }

  @override
  void dispose() {
    localDataBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      snap: false,
      centerTitle: false,
      backgroundColor: ThemeColor.base.color,
      title: TextWidget(text: S.of(context).product_details_page_app_bar_title),
      expandedHeight: context.isMobile ? 256 : 400,
      leading: context.canPop ? BackButton(color: Colors.black) : null,
      flexibleSpace: FlexibleSpaceBar(
        background: ImageWidget(
          image: widget.product.image,
          fit: BoxFit.contain,
          decoration: BoxDecoration(color: Colors.white),
          imageBuilder: (context, image) => Stack(
            children: [
              Positioned.fill(child: image),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    if (localDataBloc.dataIsExist(widget.product.id).data as bool) {
                      localDataBloc.removeLocalData(widget.product.id);
                    } else {
                      localDataBloc.storeLocalData(widget.product);
                    }
                  },
                  icon: BlocBuilder<LocalDataBloc, LocalDataState>(
                    bloc: localDataBloc,
                    builder: (context, state) {
                      return state.maybeMap(
                          loading: (value) => const CircularProgressIndicator(),
                          successStoreProduct: (value) {
                            final isFavorite = value.result;
                            return Icon(
                              isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                              color: ThemeColor.errorColor.color,
                            );
                          },
                          removeProduct: (value) {
                            final isFavorite = value.result;
                            return Icon(
                              isFavorite ? FontAwesomeIcons.heart : FontAwesomeIcons.solidHeart,
                              color: ThemeColor.errorColor.color,
                            );
                          },
                          orElse: () {
                            return Icon(
                              (localDataBloc.dataIsExist(widget.product.id).data as bool)
                                  ? FontAwesomeIcons.solidHeart
                                  : FontAwesomeIcons.heart,
                              color: ThemeColor.errorColor.color,
                            );
                          });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
