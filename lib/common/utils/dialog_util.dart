import '../exports/common_lib.dart';

///@author lihonghao
///@date 2022/8/25
///@description
class DialogUtil {
  static Future commonDialog(BuildContext context,
      {String? title,
      Widget? content,
      String? tips,
      double height = 200,
      double width = 300,
      bool showCancel = false,
      AlignmentGeometry alignment = Alignment.center,
      BorderRadius? borderRadius,
      required Function onConfirm,
      EdgeInsets? insetPadding, //宽度设置无效，需insetPadding设置边距
      Color? comfirmTextColor,
      String? cancelText,
      String? comfirmText}) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            alignment: alignment,
            contentPadding: EdgeInsets.zero,
            insetPadding: insetPadding ??
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(borderRadius: borderRadius ?? 12.br),
                child: Column(
                  children: [
                    if (title != "" && title != null)
                      Container(
                          margin: const EdgeInsets.all(20),
                          child: Text(title, style: 16.w7())),
                    Expanded(
                        child: Center(
                            child: content ??
                                Text(
                                  tips ?? '',
                                  style: 16.w4(),
                                ))),
                    Container(
                      height: 48,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: AppColors.cF0F0F0))),
                      child: Row(
                        children: [
                          if (showCancel)
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                      child: Text(
                                    cancelText ?? "取消",
                                    style: 16.w4(color: AppColors.c666666),
                                  ))),
                            ),
                          if (showCancel)
                            Container(
                              height: 88,
                              width: 1,
                              color: AppColors.cF0F0F0,
                            ),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    onConfirm();
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                      child: Text(
                                    comfirmText ?? "确定",
                                    style: 16.w4(
                                        color: comfirmTextColor ??
                                            AppColors.primaryColor),
                                  )))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
