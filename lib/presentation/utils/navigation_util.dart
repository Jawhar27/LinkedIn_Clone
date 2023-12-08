import 'package:flutter/material.dart';

void popScreen(BuildContext context, {result}) {
  Navigator.of(context).pop(result);
}

Future pushScreen(BuildContext context, String route,
    {Object? arguments}) async {
  return await Navigator.of(context).pushNamed(
    route,
    arguments: arguments,
  );
}

void moveToScreen(BuildContext context, String route, {Object? arguments}) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    route,
    (route) => false,
    arguments: arguments,
  );
}