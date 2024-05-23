///@author Hao
///@date 2022/7/20
///请求的分页参数
class PaginatedParams {
  ///请求的当前页
  late int current;

  ///请求的页数
  late int size;

  Map<String, dynamic> extra = {};

  Map<String, dynamic> model = {};

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current'] = current;
    data['size'] = size;
    data.addAll(extra);
    return data;
  }
}
