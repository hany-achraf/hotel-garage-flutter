import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/helpers/index.dart' as helpers;
import '../../../../core/networking/api.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../data/models/visit.dart';

class EndVisitPage extends StatefulWidget {
  const EndVisitPage({
    Key? key,
    required this.qrCode,
  }) : super(key: key);

  final String qrCode;

  @override
  State<EndVisitPage> createState() => _EndVisitPageState();
}

class _EndVisitPageState extends State<EndVisitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<Visit>(
          future: sl<Api>().getVisit(widget.qrCode),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.warning_rounded,
                        color: Colors.red,
                        size: 64.sp,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Something went wrong. Please try again later.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Center(
              child: Card(
                color: Colors.grey.shade300,
                margin: EdgeInsets.all(24.r),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Plate No.:',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            snapshot.data!.plateNo,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email:',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            snapshot.data!.email ?? 'N/A',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone No.:',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            snapshot.data!.phoneNo ?? 'N/A',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      if (snapshot.data!.isPaid) ...[
                        Text(
                          'Fees are paid, customer is good to go',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              int exitGuardId =
                                  helpers.getUserIdFromLocalStorage()!;

                              await sl<Api>().endVisit(
                                id: snapshot.data!.id,
                                exitGuardId: exitGuardId,
                                exitGateId: 3,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Visit ended successfully',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );

                              Navigator.of(context).popUntil(
                                ModalRoute.withName(Routes.home),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'An error occurred. Please try again later.',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white),
                          child: Text(
                            'End Visit',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Fees are not paid, customer needs to settle payment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white),
                              child: Text(
                                'Settle Payment',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ),
                            // Refresg elevatedbutton
                            ElevatedButton(
                              onPressed: () => setState(() {}),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: AppColors.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                              ),
                              child: Text(
                                'Refresh ↻',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
