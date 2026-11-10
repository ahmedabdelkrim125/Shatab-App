import 'package:flutter/widgets.dart';

extension PageControllerOffset on PageController {
  double get currentPage {
    if (hasClients && position.haveDimensions) {
      return page ?? initialPage.toDouble();
    }
    return initialPage.toDouble();
  }
}