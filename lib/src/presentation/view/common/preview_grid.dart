import 'package:ecommerce_test/src/core/utils/extension.dart';
import 'package:flutter/material.dart';

class PreviewGrid<T> extends StatelessWidget {
  final List<T> data;
  final Widget Function(BuildContext context, int index) builder;
  const PreviewGrid({
    super.key,
    required this.data,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(bottom: context.bottomPadding),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 420,
        mainAxisExtent: _calculateHeight(context),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: data.length,
      itemBuilder: builder,
    );
  }

  double _calculateHeight(BuildContext context) {
    final height = context.sizeSide.smallSide * .15;
    if (height > 100) {
      return 100;
    } else if (height < 86) {
      return 86;
    }
    return height;
  }
}
