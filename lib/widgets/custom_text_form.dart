import 'package:flutter/services.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/common/utils/reg_util.dart';

///author:lihonghao
///date:2022/09/30
///内容输入框
class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    Key? key,
    this.width,
    this.hight,
    this.margin,
    this.borderRadius,
    this.maxLines,
    this.maxLength,
    required this.value,
    required this.onChange,
    required this.hintText,
    this.inputFormatters,
  }) : super(key: key);
  final EdgeInsets? margin;
  final double? width;
  final double? hight;
  final int? maxLines;
  final int? maxLength;
  final double? borderRadius;
  final String value;
  final Function onChange;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(left: 20.w, right: 20.w),
      width: width ?? 320.w,
      height: hight ?? 160.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 12.w),
        color: AppColors.cF8F8F8,
      ),
      child: TextFormField(
        controller: TextEditingController(text: value),
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: (v) => onChange(v),
        scrollPadding: const EdgeInsets.all(0),
        style: 14.w4(),
        keyboardType: TextInputType.multiline,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 14,
          ),
          hintText: hintText,
          hintStyle: 14.w4(color: AppColors.c999999),
          border: InputBorder.none,
        ),
        buildCounter: (BuildContext context,
            {required int currentLength,
            int? maxLength,
            required bool isFocused}) {
          return Text(
            "$currentLength/$maxLength",
            style: 14.w4(color: AppColors.c999999),
          ).paddingOnly(bottom: 10);
        },
      ),
    );
  }
}
