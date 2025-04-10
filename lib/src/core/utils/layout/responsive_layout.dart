// Flutter imports:
import 'package:ecommerce_test/src/core/config/injector.dart';
import 'package:ecommerce_test/src/core/services/setting_service.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_test/src/core/utils/extension.dart';
import 'package:ecommerce_test/src/presentation/view/common/text_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecommerce_test/src/presentation/view/pages/favorites/favorites_page.dart';
// Project imports:
import '../../../presentation/view/common/custom_padding.dart';
import '../../config/theme/dark_theme.dart';
import '../../config/theme/light_theme.dart';
import '../constant.dart';
import '../enums.dart';
import 'information_page.dart';

class ResponsiveLayout extends StatefulWidget {
  final Function(BuildContext context, InformationPage info) builder;
  final Color? backgroundColor;
  final String? titleAppBar;
  final bool? isPadding;
  final bool? resizeToAvoidBottomInset;
  final bool? showAppBar;
  final bool? showAppBarActions;
  final VoidCallback? onBack;

  const ResponsiveLayout({
    super.key,
    required this.builder,
    this.titleAppBar,
    this.backgroundColor,
    this.isPadding = true,
    this.resizeToAvoidBottomInset = false,
    this.onBack,
    this.showAppBar = true,
    this.showAppBarActions = false,
  }) : assert((showAppBar == true && titleAppBar != null) || showAppBar == false);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    InformationPage infoPage = InformationPage(
      screenWidth: context.sizeSide.width,
      screenHeight: context.sizeSide.height,
      bottomPadding: context.bottomPadding,
    );

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (isPop, _) {
        widget.onBack?.call();
      },
      child: SafeArea(
        maintainBottomViewPadding: true,
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: Scaffold(
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          extendBody: true,
          backgroundColor: widget.backgroundColor,
          appBar: widget.showAppBar!
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarHeight),
                  child: AppBar(
                    centerTitle: false,
                    // backgroundColor: kMainColor,
                    elevation: 20,
                    scrolledUnderElevation: 30,
                    title: TextWidget(text: widget.titleAppBar!),
                    actions: widget.showAppBarActions!
                        ? [
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.heartCircleCheck,
                                color: ThemeColor.errorColor.color,
                              ),
                              onPressed: () => context.push(const FavoritesPage()),
                            ),
                            ListenableBuilder(
                              listenable: injector<SettingService>(),
                              builder: (context, child) {
                                return IconButton(
                                  icon: Icon(
                                    SettingService.isDark ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
                                    color: ThemeColor.reverseBase.color,
                                  ),
                                  onPressed: () {
                                    if (SettingService.isDark) {
                                      injector<SettingService>().changeTheme(theme: LightTheme());
                                      return;
                                    }
                                    injector<SettingService>().changeTheme(theme: DarkTheme());
                                  },
                                );
                              },
                            ),
                          ]
                        : null,
                  ),
                )
              : null,
          body: SafeArea(
            maintainBottomViewPadding: true,
            child: SizedBox(
              height: infoPage.screenHeight,
              width: infoPage.screenWidth,
              child: CustomPadding(
                  top: widget.isPadding! ? infoPage.screenWidth * (context.orientationInfo.isPortrait ? 0.03 : 0.01) : 0.0,
                  start: widget.isPadding! ? context.sizeSide.smallSide * 0.03 : 0.0,
                  end: widget.isPadding! ? context.sizeSide.smallSide * 0.03 : 0.0,
                  bottom: !widget.resizeToAvoidBottomInset! ? context.viewInsets.bottom : null,
                  child: Builder(
                    builder: (context) {
                      infoPage = infoPage.copyWith(context: context);
                      return widget.builder(context, infoPage);
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
