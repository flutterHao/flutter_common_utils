// import 'package:auto_orientation/auto_orientation.dart';
import 'package:common_utils/common_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib_shared/common/exports/web_lib.dart';
import 'package:flutter_lib_shared/generated/r.dart';
import 'package:get/get.dart';

///author: Hao
///date:2022/08/25
///discrible:视频播放
class VideoPlay extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  VideoPlay(
      {Key? key,
      required this.url,
      this.loadImg,
      this.showProgress = false,
      this.fullScreen = false,
      this.hideBtn = false,
      this.keepAlive = false,
      this.controller,
      this.onTapCallBack})
      : super(key: key);
  final String url; //视频地址
  final String? loadImg; //加载中背景图
  final bool showProgress; //展示进度条
  final bool fullScreen; //全屏
  final bool hideBtn; //隐藏声量和全屏按钮
  final VideoPlayerController? controller;
  final bool keepAlive; //保持状态
  final Function? onTapCallBack; //点击回调

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late VideoPlayerController _controller;
  RxDouble progressValue = 0.0.obs; //进度
  RxString totalTime = "00:00".obs;
  RxString currentTime = "00:00".obs; //tip内容
  RxBool soundOpen = true.obs;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
        ..initialize().then((_) async {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.wifi) {
            _controller.play();
          }
          setState(() {});
        });
    } else {
      _controller = widget.controller!;
    }
    _controller.addListener(() {
      //进度条的播放进度，用当前播放时间除视频总长度得到
      if (_controller.value.duration.inMilliseconds != 0) {
        progressValue.value = _controller.value.position.inMilliseconds /
            _controller.value.duration.inMilliseconds;
      }
      currentTime.value = DateUtil.formatDateMs(
          _controller.value.position.inMilliseconds,
          format: "mm:ss");
      totalTime.value = DateUtil.formatDateMs(
          _controller.value.duration.inMilliseconds,
          format: "mm:ss");
    });

    soundOpen.value = widget.fullScreen ? true : false;
    _controller.setVolume(widget.fullScreen ? 100 : 0);
  }

  @override
  void dispose() async {
    super.dispose();
    if (!widget.fullScreen && !widget.keepAlive) _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp]);
        // await AutoOrientation.portraitAutoMode(); //纵向
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: InkWell(
          onTap: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Stack(children: [
            _video(),
            _iconPlay(),
            _iconQuit(),
            if (!widget.fullScreen && !widget.hideBtn)
              Positioned(bottom: 8, left: 8, child: _iconSound()),
            widget.fullScreen ? _progress() : _iconFullScreen(),
          ]),
        ),
      ),
    );
  }

  _iconQuit() {
    return widget.fullScreen
        ? Positioned(
            top: 20,
            left: 20,
            child: InkWell(
              onTap: () async {
                await SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.portraitUp]);
                // await AutoOrientation.portraitAutoMode(); //纵向
                Get.back(result: _controller);
              },
              child: Image.asset(
                R.iconQuit,
                package: 'flutter_lib_shared',
                width: 32,
                height: 32,
                fit: BoxFit.fill,
              ),
            ))
        : Container();
  }

  _iconPlay() {
    return InkWell(
      onTap: () {
        setState(() {
          if (widget.onTapCallBack == null) {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          } else {
            widget.onTapCallBack!();
          }
        });
      },
      child: !_controller.value.isPlaying
          ? Center(
              child: Image.asset(
              R.iconPlay,
              width: 40,
              height: 40,
              package: 'flutter_lib_shared',
            ))
          : Center(
              child: identical(0, 0.0)
                  ? Image.asset(
                      R.iconPause,
                      width: 40,
                      height: 40,
                      package: 'flutter_lib_shared',
                    )
                  : Container(),
            ),
    );
  }

  Widget _iconFullScreen() {
    return !widget.hideBtn
        ? Positioned(
            bottom: 8,
            right: 8,
            child: InkWell(
              onTap: () async {
                await SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.landscapeLeft]);
                // await AutoOrientation.landscapeRightMode(); //横向
                VideoPlayerController result = await Get.to(VideoPlay(
                  url: widget.url,
                  fullScreen: true,
                  controller: _controller,
                ));

                ///web返回后数据需要重新初始化
                if (identical(0, 0.0)) {
                  await _controller.initialize().then((value) {
                    int inMilliseconds =
                        (_controller.value.duration.inMilliseconds *
                                progressValue.value)
                            .ceil();
                    _controller.seekTo(Duration(milliseconds: inMilliseconds));
                    _controller.setVolume(result.value.volume);
                    soundOpen.value = result.value.volume > 0 ? true : false;
                  });

                  // _controller = result;
                  // _controller.play();
                }
              },
              child: Image.asset(
                R.iconFullScreen,
                width: 32,
                height: 32,
                package: 'flutter_lib_shared',
                fit: BoxFit.fill,
              ),
            ),
          )
        : Container();
  }

  Widget _video() {
    return _controller.value.isInitialized
        ? Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        : Container(
            decoration: widget.loadImg != null
                ? BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.loadImg!),
                        fit: BoxFit.cover),
                  )
                : null,
            child: const Center(
              //视频加载时的圆型进度条
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ),
          );
  }

  ///进度条
  Widget _progress() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Obx(() {
              return Text(
                "$currentTime",
                style: const TextStyle(color: Colors.white),
              );
            }),
            Expanded(
              child: Obx(() {
                double size = _controller.value.isPlaying ? 2 : 4;
                double progress = progressValue.value;
                return SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white70,
                      thumbColor: Colors.white,
                      thumbShape: RoundSliderThumbShape(
                        disabledThumbRadius: 15, //禁用时滑块大小
                        enabledThumbRadius: size, //滑块大小
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 10, //滑块外圈大小
                      ),
                    ),
                    child: Slider(
                      value: progress,
                      onChanged: (value) {
                        int inMilliseconds =
                            (_controller.value.duration.inMilliseconds * value)
                                .ceil();
                        _controller
                            .seekTo(Duration(milliseconds: inMilliseconds));
                        progress = value;
                      },
                    ));
              }),
            ),
            Obx(() {
              return Text(
                "$totalTime",
                style: const TextStyle(color: Colors.white),
              );
            }),
            _iconSound(),
          ],
        ),
      ),
    );
  }

  Widget _iconSound() {
    return InkWell(
      onTap: () {
        soundOpen.value = !soundOpen.value;
        _controller.setVolume(soundOpen.value ? 100 : 0);
      },
      child: Obx(() => Image.asset(
            soundOpen.value ? R.soundOpen : R.soundClose,
            width: 32,
            height: 32,
            package: 'flutter_lib_shared',
            fit: BoxFit.fill,
          )),
    );
  }
}
