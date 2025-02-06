enum ApiRoute {
  product('/products'),
  ;

  final String route;

  const ApiRoute(this.route);
}

enum DeviceScreenType { mobile, tablet }

enum ThemeColor {
  base,
  reverseBase,
  primary,
  secondary,
  textPrimary,
  textAccent,
  textSecondary,
  cardPrimary,
  cardSecondary,
  successColor,
  errorColor,
  warningColor,
}
