import 'dart:convert';

import 'package:app/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/models/user.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final User _user;

  @override
  void initState() {
    super.initState();
    _user =
        User.fromJson(jsonDecode(sl<SharedPreferences>().getString('user')!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Hi, ${_user.name}',
          style: const TextStyle(color: AppColors.primary),
        ),
        actions: [
          IconButton(
            onPressed: () {
              sl<SharedPreferences>().remove('user');
              sl<SharedPreferences>().remove('token');
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.login,
                (_) => false,
              );
            },
            icon: Icon(
              Icons.logout,
              color: AppColors.primary,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                Routes.qrScanner,
                arguments: Routes.newVisitPage,
              ),
              child: Container(
                height: 0.25.sh,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New Visit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Icon(
                      Icons.garage_rounded,
                      color: Colors.white,
                      size: 48.sp,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                Routes.qrScanner,
                arguments: Routes.endVisitPage,
              ),
              child: Container(
                height: 0.25.sh,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2.sp,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'End Visit',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Icon(
                      Icons.exit_to_app_rounded,
                      color: AppColors.primary,
                      size: 48.sp,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
