import 'package:flutter/material.dart';

import 'middlewares/logged_in_middleware.dart';
import 'routes.dart';

Map<String, List<bool Function(RouteSettings)>> routeMiddlewares = {
  Routes.home: [loggedinMiddleware],
};
