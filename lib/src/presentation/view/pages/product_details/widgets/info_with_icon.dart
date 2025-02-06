import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ecommerce_test/src/core/utils/extension.dart';

import '../../../../../core/utils/enums.dart';
import '../../../common/text_widget.dart';

class InfoWithIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String info;
  const InfoWithIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        (context.sizeSide.smallSide * .02).w,
        TextWidget(
          lines: 1,
          text: info,
          overflow: TextOverflow.ellipsis,
          style: context.labelL?.copyWith(color: ThemeColor.textSecondary.color),
        ),
      ],
    );
  }
}
