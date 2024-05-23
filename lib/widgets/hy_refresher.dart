import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/common/paginated/paginated_controller.dart';
import 'package:flutter_lib_shared/common/paginated/paginated_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../generated/r.dart';

///@author Hao
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
  final Widget? builder;
  final Widget? showButton;
  final Widget? emptyWidget;
  final C? controller;
  final String? emptyText;
  final ClassicFooter? classicFooter;

  const HyRefresher(
      {Key? key,
      this.itemBuilder,
      this.tag,
      this.itemExtent,
      this.enablePullDown = true,
      this.enablePullUp = true,
      this.child,
      this.showButton,
      this.emptyWidget,
      this.controller,
      this.emptyText,
      this.classicFooter})
      : builder = null,
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
      this.emptyWidget,
      this.emptyText,
      this.classicFooter,
      this.controller})
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
    this.controller,
    this.classicFooter,
    this.emptyText,
  })  : child = null,
        builder = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    C ctrl;
    if (controller == null) {
      ctrl = Get.find(tag: tag);
    } else {
      ctrl = controller!;
    }
    return GetBuilder<C>(
      builder: (_) {
        Widget body;
        if (itemBuilder != null || child != null) {
          body = buildDefaultRefresh(ctrl);
        } else {
          body = buildCustomRefresh(ctrl);
        }
        return body;
      },
      id: ctrl.pageState.refreshId,
      tag: tag,
    );
  }

  Widget buildDefaultRefresh(PaginatedController controller) {
    Widget widget;
    if (controller.pageState.list.isEmpty) {
      widget = buildEmptyWidget()!;
    } else {
      widget = child ?? buildListView(controller);
    }
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: () {
        controller.onRefresh();
      },
      onLoading: () {
        controller.onLoadMore();
      },
      enablePullDown: true,
      enablePullUp: true,
      footer: classicFooter ?? getClassicalFooter(),
      child: widget,
    );
  }

  ///构建自定义的刷新
  Widget buildCustomRefresh(PaginatedController controller) {
    List<Widget> sliverList = [];
    if (controller.pageState.list.isEmpty) {
      sliverList.add(SliverToBoxAdapter(
        child: buildEmptyWidget(),
      ));
    } else {
      sliverList.addAll(slivers!);
    }

    return SmartRefresher.builder(
      controller: controller.refreshController,
      enablePullUp: true,
      enablePullDown: true,
      onRefresh: () {
        controller.onRefresh();
      },
      onLoading: () {
        controller.onLoadMore();
      },

      // header: MaterialHeader(),
      builder: (BuildContext context, RefreshPhysics physics) {
        return CustomScrollView(
          physics: physics,
          slivers: [getClassicHeader(), ...sliverList, getClassicalFooter()],
        );
      },
    );
  }

  // Widget buildListView1(PaginatedController controller) {
  //   return ListView.builder(
  //     itemBuilder: (context, index) =>
  //         itemBuilder!(controller.pageState.list[index], index),
  //     itemCount: controller.pageState.list.length,
  //     itemExtent: itemExtent,
  //   );
  // }

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
          emptyText ?? "暂无记录",
          style: 15.w4(color: AppColors.c999999),
        ),
        20.vGap,
        showButton == null ? const SizedBox() : showButton!
      ],
    ).marginOnly(top: 50);
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

// ClassicHeader getClassicHeader() => MaterialClassicHeader()

MaterialClassicHeader getClassicHeader() => MaterialClassicHeader();

ClassicFooter getClassicalFooter() => const ClassicFooter(
      idleText: "上拉加载更多",
      loadingText: "加载中......",
      noDataText: '已经到底啦~',
      failedText: '加载失败，重试',
      canLoadingText: '松手,加载更多',
    );
