import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

// import '../../features/notifications/data/repos/notifications_repo.dart';
// import '../../features/notifications/ui/cubits/unview_notifications_count_cubit/unviewed_notifications_count_cubit.dart';
// import '../../common/widgets/bottom_nav_bar.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/ui/cubits/login_cubit/login_cubit.dart';
import '../../features/visit/data/repos/visits_repo.dart';
import '../../features/visit/ui/cubits/new_visit_cubit/new_visit_cubit.dart';
import '../networking/api.dart';
import '../networking/dio_builder.dart';
import '../routing/app_router.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Navigation key
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  // Shared preferences
  sl.registerSingleton(await SharedPreferences.getInstance());

  // Routing
  sl.registerSingleton(AppRouter());

  // Network
  sl.registerLazySingleton(() {
    DioBuilder builder = DioBuilder();
    return builder
        .addAuthTokenInterceptor()
        .addErrorInterceptor()
        .addPrettyDioLogger()
        .withConnectTimeout(5000)
        .withReceiveTimeout(5000)
        .build();
  });

  // Register the API Service
  sl.registerLazySingleton(() => Api(sl()));

  // Repos
  sl.registerLazySingleton(() => AuthRepo(sl(), sl()));
  sl.registerLazySingleton(() => VisitsRepo(sl()));
  // sl.registerFactory(() => NotificationsRepo(sl()));

  // Cubits
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => NewVisitCubit(sl()));
  // sl.registerFactory(() => RequestOtpCubit(sl()));
  // sl.registerLazySingleton(() => BottomNavBarCubit());
  // sl.registerLazySingleton(() => UnviewedNotificationsCountCubit(sl()));
}
