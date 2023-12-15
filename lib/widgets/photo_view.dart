import 'package:flutter_lib_shared/common/exports/common_lib.dart';
import 'package:flutter_lib_shared/generated/r.dart';
import 'package:flutter_lib_shared/widgets/swiper_view.dart';
import 'package:flutter_lib_shared/widgets/video_play.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

///author: lihonghao
/// date: 2022/08/28
///文件预览
///
class FilePreView extends StatelessWidget {
  const FilePreView({Key? key, required this.list, this.index})
      : super(key: key);
  final List<String> list;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Stack(
        children: [
          Swiper(
            index: index,
            itemBuilder: (BuildContext context, int index) {
              var typeName = list[index].split(".").last.toLowerCase();
              return Center(
                  child: typeName == "mp4"
                      ? VideoPlay(url: list[index])
                      : Image.network(list[index], fit: BoxFit.cover));
            },
            itemCount: list.length,
            pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: SwiperCustomPagination(builder: (context, config) {
                  return BannerPagination(
                    config: config,
                  );
                })),
            // control: const SwiperControl(size: 20),
          ),
          // Positioned(
          //   top: 30,
          //   left: 10,
          //   child: IconButton(
          //       onPressed: () => Navigator.pop(context),
          //       icon: const Icon(
          //         Icons.arrow_back_ios,
          //         color: Colors.white,
          //       )),
          //   // child: InkWell(
          //   //   onTap: () => Navigator.pop(context),
          //   //   child: const Icon(
          //   //     Icons.arrow_back_ios,
          //   //     color: Colors.white,
          //   //   ),
          //   // child: Container(
          //   //   padding:
          //   //       const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //   //   decoration: BoxDecoration(
          //   //     color: Colors.grey,
          //   //     borderRadius: BorderRadius.circular(10),
          //   //   ),
          //   //   child: const Text("关闭"),
          //   // ),
          // ),
          // Positioned(
          //     top: 20,
          //     left: 20,
          //     child: InkWell(
          //       onTap: () => Get.back(),
          //       child: const Icon(
          //         Icons.arrow_back_ios,
          //         color: Colors.white,
          //       ),
          //     ))
        ],
      ),
    );
  }
}
