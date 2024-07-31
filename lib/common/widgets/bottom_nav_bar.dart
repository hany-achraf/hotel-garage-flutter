import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/di/injection_container.dart';
// import '../../core/routing/routes.dart';
import '../../core/theming/app_colors.dart';

class BottomNavBarCubit extends Cubit<int> {
  BottomNavBarCubit() : super(0);

  void updateIndex(int index) {
    emit(index);
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl<BottomNavBarCubit>(),
      builder: (context, state) => BottomNavigationBar(
        currentIndex: sl<BottomNavBarCubit>().state,
        onTap: (index) {
          // if (index != 2) {
          //   sl<BottomNavBarCubit>().updateIndex(index);
          // }

          // switch (index) {
          //   case 0:
          //     Navigator.of(context).popUntil(ModalRoute.withName(Routes.home));
          //     break;
          //   case 1:
          //     Navigator.of(context).pushNamed(Routes.search);
          //     break;
          //   case 2:
          //     Navigator.of(context).pushNamed(Routes.addPost);
          //     break;
          //   case 3:
          //     Navigator.of(context).pushNamed(Routes.favorites);
          //     break;
          //   case 4:
          //     Navigator.of(context).pushNamed(Routes.profileSettings);
          //     break;
          // }
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: const Color(0xFF86909E),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home.svg',
              color: sl<BottomNavBarCubit>().state == 0
                  ? AppColors.primary
                  : const Color(0xFF86909E),
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/subscriptions.svg',
              color: sl<BottomNavBarCubit>().state == 1
                  ? AppColors.primary
                  : const Color(0xFF86909E),
            ),
            label: 'الاشتراكات',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/offers.svg',
              color: sl<BottomNavBarCubit>().state == 2
                  ? AppColors.primary
                  : const Color(0xFF86909E),
            ),
            label: 'العروض',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profile.svg',
              color: sl<BottomNavBarCubit>().state == 3
                  ? AppColors.primary
                  : const Color(0xFF86909E),
            ),
            label: 'الملف الشخصي',
          ),
        ],
      ),
    );
  }
}
