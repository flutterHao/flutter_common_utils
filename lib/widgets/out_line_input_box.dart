/// author: hao
/// @data: 2022/07/20
/// @discript: 输入框
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/utils/reg_util.dart';

class OutLineInput extends StatelessWidget {
  const OutLineInput({
    Key? key,
    required this.text,
    this.inputFormatters,
    this.size,
    required this.onSubmitted,
  }) : super(key: key);
  final String text;
  final List<TextInputFormatter>? inputFormatters;
  final Function onSubmitted;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size?.width ?? 50,
      height: size?.height ?? 27,
      child: TextField(
          controller: TextEditingController(text: text),
          inputFormatters: inputFormatters ??
              [FilteringTextInputFormatter(RegUtil.numExp, allow: true)],
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onSubmitted: (v) {
            onSubmitted(v);
          }),
    );
  }
}
