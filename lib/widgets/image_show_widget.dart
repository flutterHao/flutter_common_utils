import 'package:extended_image/extended_image.dart';
import 'package:flutter_lib_shared/common/exports/common_lib.dart';

import '../../generated/r.dart';

///@author lihonghao
///@date 2022/9/14
///@description
class ImageWidget extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final String? imageFailedPath;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? loadingWidget;

  const ImageWidget(
      {Key? key,
      required this.url,
      this.width,
      this.height,
      this.imageFailedPath,
      this.borderRadius,
      this.fit = BoxFit.fill,
      this.loadingWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ObjectUtil.isEmptyString(url)) {
      return const SizedBox();
    }
    if (!ObjectUtil.isEmptyString(url) && !url.isURL) {
      return ExtendedImage.asset(url,
          fit: fit,
          width: width?.w,
          height: height?.w,
          enableMemoryCache: false,
          clearMemoryCacheWhenDispose: true);
    }
    return ExtendedImage.network(
      url,
      fit: fit,
      cache: true,
      width: width?.w,
      height: height?.w,
      borderRadius: borderRadius,
      shape: BoxShape.rectangle,
      clearMemoryCacheWhenDispose: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.failed:
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  imageFailedPath ?? R.imageFailed,
                  fit: BoxFit.fill,
                  width: 40.w,
                  height: 40.w,
                  package: 'flutter_lib_shared',
                ),
                // Positioned(
                //   bottom: 0.0,
                //   left: 0.0,
                //   right: 0.0,
                //   child: DecoratedBox(
                //       decoration:
                //           BoxDecoration(color: AppColors.cB8B8B8),
                //       child: SizedBox()),
                // )
              ],
            );
          case LoadState.loading:
            return loadingWidget ?? Container(color: Colors.grey[100]);
          case LoadState.completed:
            // TODO: Handle this case.
            break;
        }
        return null;
      },
    );
  }
}
