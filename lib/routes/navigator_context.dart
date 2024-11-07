import 'package:flutter/material.dart';

extension NavigatorContext on BuildContext {
  void pop<T extends Object?>([T? result]) {
    return Navigator.of(this).pop(result);
  }

  Future<T?> pushNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
      Route<T> newRoute,
      RoutePredicate predicate,
      ) {
    return Navigator.of(this).pushAndRemoveUntil(newRoute, predicate);
  }

  Future<T?> pushReplacement<T extends Object?>(
      Route<T> newRoute, {
        Route<dynamic>? oldRoute,
      }) {
    return Navigator.of(this).pushReplacement(newRoute, result: oldRoute);
  }
}