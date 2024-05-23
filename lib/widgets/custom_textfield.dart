import 'package:flutter/services.dart';

import '../common/exports/common_lib.dart';

///@author Hao
///@date 2022/6/30
///
class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPwd;
  final Function? onChanged;
  final bool enabled;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final Color? bgColor;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final double? paddingLeft;

  const CustomTextField(
      {Key? key,
      this.hintText,
      this.leftWidget,
      this.rightWidget,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.isPwd = false,
      this.onChanged,
      this.enabled = true,
      this.inputFormatters,
      this.bgColor,
      this.borderRadius,
      this.focusNode,
      this.textStyle,
      this.paddingLeft,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle = 14.w4();
    return Container(
      padding: EdgeInsets.only(left: paddingLeft ?? 0.0),
      decoration: BoxDecoration(
        border: border ?? Border(),
        borderRadius: borderRadius,
        color: bgColor,
      ),
      child: Row(
        children: [
          leftWidget ?? const SizedBox(),
          Expanded(
            child: TextField(
              obscureText: isPwd,
              enabled: enabled,
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              style: textStyle ?? defaultTextStyle,
              autofocus: true,
              decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                ),
                hintStyle: 14.w4(color: AppColors.c999999),
              ),
              focusNode: focusNode,
              onChanged: (v) => onChanged != null ? onChanged!(v) : null,
            ),
          ),
          Visibility(
              visible: rightWidget != null,
              replacement: const SizedBox(),
              child: rightWidget ?? const SizedBox())
        ],
      ),
    );
  }
}
