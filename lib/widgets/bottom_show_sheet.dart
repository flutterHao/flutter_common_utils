import 'package:flutter_lib_shared/common/exports/common_lib.dart';

import '../../generated/r.dart';
import 'custom_button.dart';
import 'image_show_widget.dart';

class BottomShowSheet {
  static BoxDecoration bottomBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.w),
          topRight: Radius.circular(15.w),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.w,
            spreadRadius: 0.5,
            color: Colors.grey.withOpacity(0.5),
          ),
        ]);
  }

  static void bottomShareSheet(BuildContext context,
      {required List<ShareItem> shareItems,
      required Function(ShareItem mShareItem) onPressedShareItem}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        List<Widget> shareItemWidgets = [];
        for (int i = 0; i < shareItems.length; i++) {
          ShareItem shareItem = shareItems[i];
          shareItemWidgets.add(ShareItemWidget(
            mShareItem: shareItem,
            onItemPressed: () {
              onPressedShareItem(shareItem);
            },
          ));
        }
        return Container(
          decoration: bottomBoxDecoration(),
          height: 226.w,
          // color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 62.w,
                width: MediaQuery.of(context).size.width,
                // color: Colors.yellow,
                padding: EdgeInsets.only(left: 20.w, top: 20.w),
                child: Text(
                  '分享到',
                  style: 16.w7(),
                ),
              ),
              GridView.count(
                  crossAxisCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: shareItemWidgets),
            ],
          ),
        );
      },
      backgroundColor: Colors.transparent,
    );
  }

  static void bottomPaySheet(BuildContext context,
      {required List<Map<String, String>> shareItems,
      required Function(int index) onPressedItem}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        int selectedIndex = 0;
        return Container(
          decoration: bottomBoxDecoration(),
          height: shareItems.length <= 2 ? 226.w : 300.w,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              StatefulBuilder(builder: (context, setState) {
                return Column(
                    children: shareItems.map((e) {
                  return InkWell(
                    onTap: () {
                      selectedIndex = shareItems.indexOf(e);
                      // onPressedItem(shareItems.indexOf(e));
                      setState(() {});
                    },
                    child: PayItemWidget(
                      title: e['title']!,
                      icon: e['icon']!,
                      index: shareItems.indexOf(e),
                      selectedIndex: selectedIndex,
                    ),
                  );
                }).toList());
              }),
              20.vGap,
              CustomButton(
                text: '确定',
                textColor: Colors.white,
                bgColor: AppColors.cAC6BFF,
                onClick: () {
                  onPressedItem(selectedIndex);

                  // PayUtils.payTo(maps);
                  // ctrl.createPayOrder();
                },
              )
            ],
          ),
        );
      },
      backgroundColor: Colors.transparent,
    );
  }
}

enum ShareItem {
  shareItemsWechat,
  shareItemsFriend,
  shareItemsQQ,
  shareItemsCopyLink,
}

extension ShareItemExtension on ShareItem {
  int get value {
    ShareItem.values;
    return 0;
  }
}

class ShareItemWidget extends StatelessWidget {
  const ShareItemWidget({
    Key? key,
    required this.onItemPressed,
    required this.mShareItem,
  }) : super(key: key);

  final void Function() onItemPressed;

  // final String title;
  // final Widget icon;
  final ShareItem mShareItem;

  @override
  Widget build(BuildContext context) {
    String title = '';
    Widget icon = Container();
    switch (mShareItem) {
      case ShareItem.shareItemsWechat:
        {
          title = '微信好友';
          icon = Image.asset(
            R.xiangqingIconWeixin,
            width: 50.w,
            height: 50.w,
          );
          break;
        }
      case ShareItem.shareItemsFriend:
        {
          title = '朋友圈';
          icon = Image.asset(
            R.xiangqingImgPengyouquan,
            width: 50.w,
            height: 50.w,
          );
          break;
        }
      case ShareItem.shareItemsQQ:
        {
          title = 'QQ';
          icon = Image.asset(
            R.xiangqingImgQq,
            width: 50.w,
            height: 50.w,
          );
          break;
        }
      case ShareItem.shareItemsCopyLink:
        {
          title = '复制链接';
          icon = Image.asset(
            R.xiangqingImgLianjie,
            width: 50.w,
            height: 50.w,
          );
          break;
        }
      default:
        break;
    }
    TextStyle bottomTextStyle = TextStyle(
        color: AppColors.c999999,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w400,
        fontSize: 12.0.w,
        fontFamily: 'PingFang SC');
    return Column(children: [
      6.vGap,
      IconButton(
        padding: const EdgeInsets.all(0),
        icon: icon,
        // Image.asset(RR.R.xiangqingIconWeixin, width: 50.w, height: 50.w,),
        onPressed: () {
          // Fluttertoast.cancel();
          // Fluttertoast.showToast(msg: title);
          onItemPressed();
        },
      ),
      2.vGap,
      Text(
        title,
        style: bottomTextStyle,
      )
    ]);
  }
}

class PayItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final int index;
  final int selectedIndex;

  const PayItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.index,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ImageWidget(
              url: icon,
              width: 32.w,
              height: 32.w,
            ),
            14.hGap,
            Text(title, style: 14.w4()),
          ],
        ),
        Image.asset(
            index == selectedIndex
                ? R.regIconNotChecked
                : R.regIconCheckTheAgreement,
            package: 'flutter_lib_shared'),
      ],
    ).marginOnly(top: 20);
  }
}
