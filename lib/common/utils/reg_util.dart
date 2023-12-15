///@author huangjianghe
///@date 2022/7/21
///正则表达式处理工具类
class RegUtil {
  ///仅限数字
  static RegExp numExp = RegExp(r"^(\d+)?$");
  static const String regexPassport =
      '^(?![0-9]+\$)(?![a-zA-Z]+\$)[0-9A-Za-z]{6,20}\$';
  // static final String regexPassport =
  //     r'(^[EeKkGgDdSsPpHh]\d{8}$)|(^(([Ee][a-fA-F])|([DdSsPp][Ee])|([Kk][Jj])|([Mm][Aa])|(1[45]))\d{7}$)';
  static RegExp pwdExp = RegExp(r"^[A-Za-z0-9]\+{6,20}$");

  static final nikeExp = RegExp(r"^[\u4E00-\u9FA5A-Za-z0-9_]+$");
}
