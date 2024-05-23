import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/common/exports/web_lib.dart';
import 'package:flutter_lib_shared/widgets/video_play.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

import 'image_show_widget.dart';

///@author Hao
///@date 2022/6/10
///轮播图组件
typedef SwiperOnTap = void Function(int index);

// typedef SwiperDataBuilder = Widget Function(
//     BuildContext context, dynamic data, int index);

class SwiperView extends StatelessWidget {
  const SwiperView(
      {Key? key,
      // Map<String, dynamic>? extParams,
      required this.bannerList,
      this.height,
      this.width,
      this.margin,
      this.indexColor = Colors.white,
      this.onItemTap,
      this.controller,
      this.outer = true})
      : super(key: key);

  final List<dynamic> bannerList;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final Color indexColor;
  final SwiperOnTap? onItemTap;
  final bool outer;
  final SwiperController? controller;

  @override
  Widget build(BuildContext context) {
    if (ObjectUtil.isEmptyList(bannerList)) {
      return Container();
    }

    ///轮播列表
    List<Widget> list = bannerList.map((e) {
      int index = bannerList.indexOf(e);

      Widget child = Container();
      String url = bannerList[index];

      ///视频
      if (url.isVideoFileName) {
        ///在外面初始化，防止重新页面销毁重新加载
        VideoPlayerController controller =
            VideoPlayerController.networkUrl(Uri.parse(url));
        controller.initialize().then((_) async {
          controller.setVolume(0);
          controller.play();
        });
        child = VideoPlay(
          url: url,
          hideBtn: true,
          controller: controller,
          keepAlive: true,
          onTapCallBack: () {
            onItemTap!(index);
          },
        );
      }
      //图片
      else if (url.isImageFileName) {
        child = ImageWidget(
          url: url,
          fit: BoxFit.cover,
        );
        // child = Image.network(
        //   url,
        //   fit: BoxFit.cover,
        // );
      }
      return GestureDetector(
        onTap: () {
          onItemTap!(index);
        },
        child: Container(
          height: height ?? 160.w,
          width: width ?? 320.w,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            child: child,
          ),
        ),
      );
    }).toList();

    //轮播组件
    return Container(
      // margin: EdgeInsets.only(top: 20.h),
      margin: margin ?? EdgeInsets.all(10.w),
      height: height ?? 160.w,
      width: width ?? 320.w,
      child: Swiper(
        outer: false,
        itemCount: bannerList.length,
        pagination: SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: SwiperCustomPagination(builder: (context, config) {
              return BannerPagination(
                config: config,
              );
            })),
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        },
        duration: 1000,
        autoplay: outer,
        autoplayDelay: 5000,
        controller: controller,
      ),
    );
  }
}

class BannerPagination extends StatelessWidget {
  final SwiperPluginConfig config;

  const BannerPagination({Key? key, required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(config.itemCount, (index) => getIndexChild(index)),
      ),
    );
  }

  Widget getIndexChild(int index) => index == config.activeIndex
      ? buildDotWidget(8, 3, AppColors.c333333)
      : buildDotWidget(3, 3, AppColors.cA9A9A9);

  Widget buildDotWidget(double width, double height, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(1.5.r))),
    );
  }
}
