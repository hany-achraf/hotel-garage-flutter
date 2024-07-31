import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../core/di/injection_container.dart';
import '../cubits/new_visit_cubit/new_visit_cubit.dart';

class NewVisitPage extends StatefulWidget {
  const NewVisitPage({
    Key? key,
    required this.qrCode,
  }) : super(key: key);

  final String qrCode;

  @override
  State<NewVisitPage> createState() => _NewVisitPageState();
}

class _NewVisitPageState extends State<NewVisitPage> {
  final TextEditingController _plateNoController = TextEditingController();
  // final FocusNode _plateNoFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  // final FocusNode _emailFocusNode = FocusNode();

  final TextEditingController _phoneNoController = TextEditingController();
  // final FocusNode _phoneNoFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  late final NewVisitCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<NewVisitCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewVisitCubit, NewVisitState>(
      bloc: _cubit,
      listener: (_, state) {
        state.maybeWhen(
          success: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Visit created successfully.'),
                backgroundColor: Colors.green,
                hitTestBehavior: HitTestBehavior.deferToChild,
              ),
            );

            Navigator.popUntil(
              context,
              ModalRoute.withName(Routes.home),
            );
          },
          error: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'An error occurred. Please try again later.',
                ),
                backgroundColor: Colors.red,
                hitTestBehavior: HitTestBehavior.deferToChild,
              ),
            );
          },
          orElse: () {
            // do nothing
          },
        );
      },
      builder: (_, __) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(),
          body: LayoutBuilder(builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 64.h),
                            TextFormField(
                              controller: _plateNoController,
                              // focusNode: _plateNoFocusNode,
                              decoration: const InputDecoration(
                                hintText: 'Plate Number',
                                prefixIcon: Icon(Icons.numbers_rounded),
                              ),
                              // onTap: () => setState(() {}),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Plate number is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),
                            TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                prefixIcon: Icon(Icons.email_rounded),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            TextField(
                              controller: _phoneNoController,
                              decoration: const InputDecoration(
                                hintText: 'Phone Number',
                                prefixIcon: Icon(Icons.phone_rounded),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            ElevatedButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                _cubit.createNewVisit(
                                  qrCode: widget.qrCode,
                                  plateNo: _plateNoController.text.trim(),
                                  email: _emailController.text.isEmpty
                                      ? null
                                      : _emailController.text.trim(),
                                  phoneNo: _phoneNoController.text.isEmpty
                                      ? null
                                      : _phoneNoController.text.trim(),
                                  entryGateId: 1,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.r),
                                ),
                                minimumSize: const Size(double.maxFinite, 0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
