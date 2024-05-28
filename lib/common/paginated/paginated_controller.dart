import 'package:flutter_lib_shared/common/paginated/paginated_params.dart';
import 'package:flutter_lib_shared/common/paginated/paginated_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../exports/common_lib.dart';

///@author lihonghao
///@date 2022/7/20
///
typedef GetData<M> = void Function(List<M> data, int total);

abstract class PaginatedController<M, S extends PaginatedState<M>>
    extends GetxController {
  late S pageState;
  bool isRefresh = true;
  int _pageSize = 10;

  // final EasyRefreshController _refreshController = EasyRefreshController();
  final RefreshController _refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();
    pageState = getState();
  }

  // EasyRefreshController get refreshController => _refreshController;
  RefreshController get refreshController => _refreshController;

  void setPageSize(int size) {
    _pageSize = size;
  }

  @override
  void onReady() {
    onRefresh();
    super.onReady();
  }

  @override
  void onClose() {
    _refreshController.dispose();

    super.onClose();
  }

  void onRefresh() {
    isRefresh = true;
    pageState.pageNo = 1;
    // pageState.hasMore = true;
    pageState.list.clear();
    _loadData();
    // _refreshController.refreshCompleted();
  }

  onLoadMore() {
    if (isRefresh && pageState.list.isEmpty) {
      return;
    }
    pageState.pageNo++;
    isRefresh = false;
    _loadData();
    // _refreshController.loadComplete();
  }

  _loadData() async {
    PaginatedParams pagingParams = PaginatedParams()
      ..current = pageState.pageNo
      ..size = 10;
    requestData(pagingParams, (data, total) {
      if (isRefresh) {
        pageState.list = data;
        _refreshController.refreshCompleted(resetFooterState: true);
      } else {
        pageState.list.addAll(data);
        // pageState.hasMore = pageState.list.length <= total;
        if (pageState.list.length >= total) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
        }
      }
      update([pageState.refreshId]);
    });
  }

  requestData(PaginatedParams pagingParams, GetData<M> callback);

  /// 获取 State
  S getState();
}
