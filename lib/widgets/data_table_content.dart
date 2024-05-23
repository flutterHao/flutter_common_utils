import 'package:flutter_lib_shared/common/exports/common_lib.dart';

///@author Hao
///@date 2022/8/12
///@description

class DataTableContent extends StatefulWidget {
  final List columns;
  final List<DataRow> rows;

  const DataTableContent({Key? key, required this.columns, required this.rows})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DataTableContentState();
  }
}

class _DataTableContentState extends State<DataTableContent> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            child: DataTable(
              columns: widget.columns.map((e) {
                return DataColumn(
                    label: Text(
                  e,
                  textAlign: TextAlign.center,
                  style: const TextStyle(overflow: TextOverflow.clip),
                ));
              }).toList(),
              rows: widget.rows,
              showBottomBorder: true,
            ),
          ),
        ),
      ],
    );
  }
}
