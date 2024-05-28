import 'package:flutter/material.dart';

import '../common/paginated/page_model.dart';
import 'out_line_input_box.dart';

///@author lihonghao
///@date 2022/7/18
///@description: 表格页脚

// typedef OnPrevious = void Function(int page, int rows);
// typedef OnNext = void Function(int page, int rows);
typedef ChangedPage = void Function();
// typedef InputPageChange = void Function(int page, int rows);

class DataTableFooter extends StatefulWidget {
  // final OnPrevious onPrevious;
  // final OnNext onNext;
  final ChangedPage changePage;
  // final InputPageChange inputPageChange;
  final List<int> rowsList;
  final PageModel pageModel;
  final bool canChangeSize;

  const DataTableFooter(
      {Key? key,
      // required this.onPrevious,
      // required this.onNext,
      required this.changePage,
      // required this.inputPageChange,

      required this.pageModel,
      this.canChangeSize = true,
      this.rowsList = const [10, 20, 30]})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DataTableFooterState();
  }
}

class _DataTableFooterState extends State<DataTableFooter> {
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  // }

  // ///上一页
  // previousPage() {
  //   widget.onPrevious(currentPage, widget.defaultRows);
  // }

  ///上一页
  previousPage() {
    int currentPage = widget.pageModel.pageNo;
    if (currentPage > 1) {
      currentPage--;
      widget.pageModel.pageNo = currentPage;
      // widget.onPrevious(currentPage, widget.pageModel.rows);
      widget.changePage();
    }
  }

//下一页
  nextPage() {
    int currentPage = widget.pageModel.pageNo;
    if (currentPage < maxPage()) {
      currentPage++;
      widget.pageModel.pageNo = currentPage;
      // widget.onNext(currentPage, widget.pageModel.rows);
      widget.changePage();
    }
  }

  int maxPage() {
    dynamic total = widget.pageModel.total;
    if (total is String) {
      total = int.parse(total);
    }
    int rows = widget.pageModel.rows;
    var maxPage = (total / rows);
    return maxPage.ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("共 ${widget.pageModel.total} 条"),

            ///页面上下页切换
            const SizedBox(width: 10),
            InkWell(
                onTap: (() {
                  previousPage();
                }),
                child: const Icon(
                  Icons.keyboard_arrow_left,
                )),
            item(Text("${widget.pageModel.pageNo}")),
            InkWell(
                onTap: (() {
                  nextPage();
                }),
                child: const Icon(
                  Icons.keyboard_arrow_right,
                )),
            const SizedBox(width: 10),
            if (widget.canChangeSize)
              DropdownButton(
                isDense: false,
                underline: Container(),
                value: widget.pageModel.rows,
                items: widget.rowsList.map(((e) {
                  return DropdownMenuItem(value: e, child: Text("$e条/每页"));
                })).toList(),
                onChanged: (v) {
                  // setState(() {
                  //   rows = int.parse(v.toString());
                  // });
                  // currentPage = 1;
                  widget.pageModel.rows = int.parse(v.toString());
                  widget.pageModel.pageNo = 1;
                  // widget.changePage(
                  //     widget.pageModel.pageNo, widget.pageModel.rows);
                  widget.changePage();
                },
              ),

            ///页面输入
            const SizedBox(width: 10),
            const Text("前往 "),
            OutLineInput(
                text: "${widget.pageModel.pageNo}",
                onSubmitted: (v) {
                  // setState(() {
                  //   currentPage = int.parse(v);
                  // });
                  widget.pageModel.pageNo = int.parse(v);
                  // widget.inputPageChange(
                  //     widget.pageModel.pageNo, widget.pageModel.rows);
                  widget.changePage();
                }),
            const Text(" 页"),
          ]),
    );
  }

  Widget item(Widget child) {
    return Container(
      width: 25,
      height: 25,
      margin: const EdgeInsets.all(2),
      // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: Center(child: child),
    );
  }
}
