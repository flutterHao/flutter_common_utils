import 'package:flutter_lib_shared/common/exports/common_lib.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    Key? key,
    this.leftWidget,
    this.rightWidget,
    this.hintText,
    this.onClick,
  }) : super(key: key);

  final Widget? leftWidget;
  final Widget? rightWidget;
  final dynamic hintText;
  final dynamic onClick;

  @override
  Widget build(BuildContext context) {
    _width() {
      if (leftWidget != null) {
        return 250.0.w;
      } else if (rightWidget != null) {
        return 200.0.w;
      } else {
        return 300.0.w;
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        leftWidget ?? Container(),
        Container(
          width: _width(),
          height: 44.0.h,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: AppColors.cF0F0F0,
              ),
            ),
          ),
          child: TextField(
            onChanged: (v) {
              onClick(v);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.c999999,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        rightWidget ?? Container(),
      ],
    );
  }
}
