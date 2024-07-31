import 'package:flutter/material.dart';

import '../../helpers/index.dart' as helpers;

bool loggedinMiddleware(RouteSettings settings) =>
    helpers.getUserIdFromLocalStorage() != null;