import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onTap;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final bool? obscureText;
  final Function? onSuffixTap;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    required this.onTap,
    this.prefixIcon,
    this.prefixWidget,
    this.obscureText,
    this.onSuffixTap,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.r),
      color: Colors.white,
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obscureText ?? false,
        controller: controller,
        focusNode: focusNode,
        onTap: () => onTap(),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 16.sp),
          prefixIcon: prefixIcon == null
              ? prefixWidget
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Icon(prefixIcon, size: 24.sp),
                ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.sp,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 1.sp,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
          suffixIcon: obscureText == null || onSuffixTap == null
              ? null
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: InkWell(
                    onTap: onSuffixTap as void Function()?,
                    child: Icon(
                      obscureText!
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 24.sp,
                      color: const Color(0xFF171930),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
