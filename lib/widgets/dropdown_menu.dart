import 'package:bs_flutter/bs_flutter.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';

///@author Hao
///@date 2022/8/23
///@description 下拉菜单组件
class DropdownMenu extends StatelessWidget {
  const DropdownMenu(
      {Key? key,
      required this.leftText,
      this.hintText,
      this.select,
      this.onChange,
      this.onClear,
      this.onClose,
      this.paddingRight = 5.0,
      this.textStyle,
      required this.options,
      this.selectedVal,
      this.selectedText,
      this.disabled = false,
      this.width = 0.0})
      : super(key: key);

  final String? leftText;
  final String? hintText;
  final BsSelectBoxController? select;
  final dynamic onChange;
  final dynamic onClear;
  final dynamic onClose;
  final TextStyle? textStyle;
  final double paddingRight;
  final Map options;

  // final Object? selectedVal;
  final String? selectedText;
  final List? selectedVal;
  final double width;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(right: paddingRight),
          child: Text('$leftText: ',
              style: textStyle ?? 14.w4(color: AppColors.c333333)),
        ),
        SizedBox(
          width: 200.0,
          height: 36.0,
          child: BsSelectBox(
            padding: const EdgeInsets.all(7.0),
            hintText: hintText,
            controller: select ??
                BsSelectBoxController(
                    options: options.keys
                        .map((e) => BsSelectBoxOption(
                            value: e, text: Text('${options[e]}')))
                        .toList(),
                    selected: ObjectUtil.isEmptyList(selectedVal)
                        ? null
                        : selectedVal
                            ?.map((e) => BsSelectBoxOption(
                                value: e, text: Text('${options[e] ?? ''}')))
                            .toList()),
            disabled: disabled,
            onOpen: () {},
            onChange: (option) {
              onChange(option.getValue());
            },
            onClear: onClear,
            onClose: onClose,
          ),
        ),
      ],
    );
  }
}
