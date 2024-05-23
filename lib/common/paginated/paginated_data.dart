///@author Hao
///@date 2022/7/20
///接收网络返回的数据
class PaginatedData<T> {
  ///数据
  late List<T> list;

  ///总页数
  late int total;

  ///当前页
  late int pageNo;
}
