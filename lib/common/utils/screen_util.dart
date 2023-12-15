import 'dart:ui';

/**
 * @Author: Sky24n
 * @GitHub: https://github.com/Sky24n
 * @Email: sky24no@gmail.com
 * @Description: Screen Util.
 * @Date: 2018/9/8
 */

///默认设计稿尺寸（单位 dp or pt）
double _designW = 360.0;
double _designH = 640.0;
double _designD = 3.0;

/**
 * 配置设计稿尺寸（单位 dp or pt）
 * w 宽
 * h 高
 * density 像素密度
 */

/// 配置设计稿尺寸 屏幕 宽，高，密度。
/// Configuration design draft size  screen width, height, density.
void setDesignWHD(double? w, double? h, {double? density = 3.0}) {
  _designW = w ?? _designW;
  _designH = h ?? _designH;
  _designD = density ?? _designD;
}

/// Screen Util.
class ScreenUtils {
  double phySicalWidth = 0;
  double phySicalHeight = 0;

  double screenWidth = 0;
  double screenHeight = 0;

  double dpr = 0;
  double px = 0;

  double statusBarHeight = 0;
  double bottomHeight = 0;

  //初始化
  static void initialize() {}
  //工厂方法构造函数
  factory ScreenUtils() => _getInstance();

  //instance的getter方法
  static ScreenUtils get instance => _getInstance();

  //静态变量 _instace, 存储唯一对象
  // 这里必须要使用？ 声明可选值， 不然不可以赋值null
  static ScreenUtils? _instance;

  //获取对象
  static ScreenUtils _getInstance() {
    _instance ??= ScreenUtils._internal();

    return _instance!;
  }

  //私有的命名构造法方法 ,默认的构造方法将失效， 这样就隐藏了构造方法
  //子类不能继承internal
  //不是关键字，可定义其它名字
  ScreenUtils._internal() {
    // 初始化
    //分辨率
    phySicalWidth = window.physicalSize.width;
    phySicalHeight = window.physicalSize.height;

    // 屏幕宽高
    screenWidth = window.physicalSize.width / window.devicePixelRatio;
    screenHeight = window.physicalSize.height / window.devicePixelRatio;

    //这里是以iphone6 为模板来适配的
    dpr = screenWidth / 750; // 像素点适配
    px = screenWidth / 750 * 2; // 物理宽度适配

    //导航栏和底部工具栏的高度
    statusBarHeight = window.padding.top;
    bottomHeight = window.padding.bottom;
  }
}


//给double写一个分类
extension sizeFit on double {
  //使用像素适配大小
  double dpx() {
    return this * ScreenUtils.instance.dpr;
  }

  // 使用px（物理宽度适配）
  double px() {
    return this * ScreenUtils.instance.px;
  }
}
