import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/common/paginated/paginated_controller.dart';
import 'package:flutter_lib_shared/common/paginated/paginated_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../generated/r.dart';
import 'classic_footer.dart' as footer;
import 'classic_header.dart' as header;

///@author lihonghao
///@date 2022/7/27
///@description 下拉刷新
///
// typedef IndexedWidgetBuilder = Widget Function(T t,int index;)
class HyRefresher<T, C extends PaginatedController<T, PaginatedState<T>>>
    extends StatelessWidget {
  final Function(T item, int index)? itemBuilder;
  final String? tag;
  final double? itemExtent;
  final bool enablePullUp;

  final bool enablePullDown;
  final List<Widget>? slivers;
  final Widget? child;
  final EasyRefreshChildBuilder? builder;
  final Widget? showButton;
  final Widget? emptyWidget;
  const HyRefresher({
    Key? key,
    this.itemBuilder,
    this.tag,
    this.itemExtent,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.child,
    this.showButton,
    this.emptyWidget,
  })  : builder = null,
        slivers = null,
        super(key: key);

  const HyRefresher.builder(
      {Key? key,
      this.itemBuilder,
      this.tag,
      this.itemExtent,
      this.enablePullDown = true,
      this.enablePullUp = true,
      this.showButton,
      required this.builder,
      this.emptyWidget})
      : child = null,
        slivers = null,
        super(key: key);

  const HyRefresher.custom({
    Key? key,
    this.itemBuilder,
    this.tag,
    this.itemExtent,
    this.enablePullDown = true,
    this.enablePullUp = true,
    required this.slivers,
    this.showButton,
    this.emptyWidget,
  })  : child = null,
        builder = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    C controller = Get.find(tag: tag);

    return GetBuilder<C>(
      builder: (_) {
        Widget body;
        if (itemBuilder != null || child != null) {
          body = buildDefaultRefresh(controller);
        } else {
          if (builder != null) {
            body = buildRefresh(controller);
          } else {
            body = buildCustomRefresh(controller);
          }
        }

        return body;
      },
      id: controller.pageState.refreshId,
      tag: tag,
    );
  }

  Widget buildSmart(controller) {
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoadMore,
      footer: const ClassicFooter(
        idleText: "上拉加载更多",
        canLoadingText: "松开加载更多",
        loadingText: "加载中......",
      ),
      // header:  ClassicHeader(
      //   idleText: "下拉刷新",
      //   releaseText: "松开刷新",
      //   completeText: "刷新完成",
      //   refreshingText: "加载中......",
      //   releaseIcon: Icon(Icons.arrow_upward, color: Colors.grey),
      // ),
      child: buildListView(controller),
    );
  }

  ///构建默认的刷新
  Widget buildDefaultRefresh(controller) {
    List list = controller.pageState.list;
    return EasyRefresh(
      controller: controller.refreshController,
      onRefresh: () async {
        controller.onRefresh();
      },
      onLoad: () async {
        controller.onLoadMore();
      },
      footer: getClassicalFooter(),
      header: MaterialHeader(),
      // enableControlFinishRefresh: enablePullUp,
      // enableControlFinishLoad:
      //     enablePullDown && controller.pageState.hasMore,
      child: child ?? buildListView(controller),
      emptyWidget: ObjectUtil.isEmptyList(list) ? buildEmptyWidget() : null,
    );
  }

  ///构建自定义的刷新
  Widget buildRefresh(controller) {
    return EasyRefresh.builder(
      controller: controller.refreshController,
      onRefresh: () async {
        controller.onRefresh();
      },
      onLoad: () async {
        controller.onLoadMore();
      },
      footer: getClassicalFooter(),
      header: MaterialHeader(),
      builder: builder,
    );
  }

  ///构建自定义的刷新
  Widget buildCustomRefresh(controller) {
    List list = controller.pageState.list;
    return EasyRefresh.custom(
      controller: controller.refreshController,
      onRefresh: () async {
        controller.onRefresh();
      },
      onLoad: () async {
        controller.onLoadMore();
      },
      footer: getClassicalFooter(),
      header: MaterialHeader(),
      slivers: slivers,
      emptyWidget: ObjectUtil.isEmptyList(list) ? buildEmptyWidget() : null,
    );
  }

  Widget? buildEmptyWidget() {
    if (emptyWidget != null) {
      return emptyWidget;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(R.dlgImgNoRecord, package: 'flutter_lib_shared'),
        Text(
          "暂无记录",
          style: 15.w4(color: AppColors.c999999),
        ),
        20.vGap,
        showButton == null ? const SizedBox() : showButton!
      ],
    );
  }

  Widget buildListView(PaginatedController controller) {
    return ListView.builder(
      itemBuilder: (context, index) =>
          itemBuilder!(controller.pageState.list[index], index),
      itemCount: controller.pageState.list.length,
      itemExtent: itemExtent,
    );
  }
}

header.ClassicHeader getClassicHeader() => header.ClassicHeader(
      showInfo: false,
      refreshText: "下拉刷新",
      refreshReadyText: "松开刷新",
      refreshedText: "刷新完成",
      refreshingText: "加载中......", textColor: Colors.grey,
      // releaseIcon: Icon(Icons.arrow_upward, color: Colors.grey),
    );

// ClassicHeader getClassicHeader() => ClassicHeader(
//   showInfo: false,
//   refreshText: "下拉刷新",
//   refreshReadyText: "松开刷新",
//   refreshedText: "刷新完成",
//   refreshingText: "加载中......",
//   // releaseIcon: Icon(Icons.arrow_upward, color: Colors.grey),
// );
footer.ClassicFooter getClassicalFooter() => footer.ClassicFooter(
      loadText: "上拉加载更多",
      loadReadyText: "松开加载更多",
      loadingText: "加载中......",
      loadedText: '',
      noMoreText: '已经到底啦~',
      loadFailedText: '加载失败，重试',
      textColor: Colors.grey,
      showInfo: false,
    );
