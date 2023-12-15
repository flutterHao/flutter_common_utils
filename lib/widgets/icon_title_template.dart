import 'package:flutter_lib_shared/common/exports/common_lib.dart';

import 'image_show_widget.dart';


// ignore: must_be_immutable
class IconTitleTemplate extends StatelessWidget {
  IconTitleTemplate(
      {Key? key,
      required this.list,
      required this.title,
      required this.changeCallBack})
      : super(key: key);

  late List list;
  final String? title;
  final void Function(int index) changeCallBack;

  printNumber() {
    List<Widget> data = [];
    for (var i = 0; i < list.length; i++) {
      data.add(Container(
        margin: EdgeInsets.fromLTRB(0, 0, 18.w, 0),
        child: ImageText(
          image: list[i][ConstantComponent.url],
          text: list[i][ConstantComponent.name],
          onClick: () {
            changeCallBack(i);
          },
        ),
      ));
    }

    return Row(
      children: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    // changeCallBack = (item) => print(
    //     'item ==> $item',
    //   );

    return Container(
      padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // height: 20.0.h,
            padding: EdgeInsets.only(left: 20.0.w),
            child: Text(
              title ?? '最近更新',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color.fromRGBO(51, 51, 51, 1),
              ),
            ),
          ),
          10.vGap,
          SizedBox(
            height: 88.w,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20.0.w, right: 2.0.w),
              children: <Widget>[
                printNumber(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _IconTitleTemplateState extends State<IconTitleTemplate> {
// }

class ImageText extends StatelessWidget {
  const ImageText({
    Key? key,
    required this.image,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  final dynamic image;
  final dynamic text;
  final dynamic onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        children: <Widget>[
          ImageWidget(
            url: image,
            width: 64,
            height: 64,
            borderRadius: 12.br,
          ),
          6.vGap,
          SizedBox(
            width: 60.0.w,
            child: Text(
              '$text',
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: 10.w7(),
            ),
          ),
        ],
      ),
    );
  }
}
