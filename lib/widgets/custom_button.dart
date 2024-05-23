import 'package:flutter_lib_shared/common/exports/common_lib.dart';

///@author Hao
///@date 2022/6/30
///自定义按钮
class CustomButton extends StatefulWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final double fontSize;
  final double radius;
  final double paddingVertical;
  final double paddingHorizontal;

  final double marginVertical;
  final double marginHorizontal;
  final double? width;
  final double? height;
  final Function? onClick;
  final FontWeight? fontWeight;
  final Widget? child;
  final Border? border;

  // final List<Color>? colors;
  final Gradient? gradient;

  final bool isDebounce;

  const CustomButton(
      {Key? key,
      required this.text,
      this.bgColor = AppColors.cAC6BFF,
      this.textColor = AppColors.white,
      this.fontSize = 16,
      this.radius = 20,
      this.paddingVertical = 10.0,
      this.paddingHorizontal = 10.0,
      this.marginVertical = 0.0,
      this.marginHorizontal = 0.0,
      this.width,
      this.height,
      this.onClick,
      this.fontWeight,
      this.isDebounce = true,
      this.child,
      this.gradient,
      this.border})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomButtonState();
  }
}

class _CustomButtonState extends State<CustomButton> {
  final isClicked = false.obs;

  @override
  void initState() {
    if (widget.isDebounce) {
      if (widget.onClick != null) {
        debounce(isClicked, (callback) => widget.onClick!(),
            time: Duration(milliseconds: 300));
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isDebounce) {
          if (widget.onClick != null) {
            isClicked.value = !isClicked.value;
          }
        } else {
          if (widget.onClick != null) {
            widget.onClick!();
          }
        }
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: EdgeInsets.symmetric(
            vertical: widget.marginVertical,
            horizontal: widget.marginHorizontal),
        padding: EdgeInsets.symmetric(
            vertical: widget.paddingVertical,
            horizontal: widget.paddingHorizontal),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: widget.border,
            borderRadius: widget.radius.br,
            color: widget.bgColor,
            gradient: widget.gradient),
        child: widget.child ??
            Text(widget.text,
                style: widget.fontSize
                    .w9(color: widget.textColor)
                    .copyWith(fontWeight: widget.fontWeight)),
      ),
    );
  }
}
