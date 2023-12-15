class PaginatedState<T> {
  ///网络返回的数据
  List<T> list = [];

  ///当前页数
  late int pageNo;

  ///要刷新的widget
  Object refreshId = Object();

  ///是否还有加载更多
  bool hasMore = true;
}
