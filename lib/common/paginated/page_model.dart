///@author lihonghao
///@date 2022/8/3
///@description 主要web端使用分页数据模型
class PageModel {
  ///总页数
  dynamic total = 0;

  ///当前页
  dynamic pageNo = 1;

  ///行数
  dynamic rows = 10;
}

class PageState {
  final PageModel pageModel = PageModel();
}
