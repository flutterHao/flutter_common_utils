import 'package:flutter_lib_shared/common/exports/common_lib.dart';

///字体大小
class Dimens {
  static const double minTextSize = 8;
  static const double smallTextSize = 10;
  static const double small1TextSize = 12;
  static const double middleTextSize = 14;
  static const double normalTextSize = 16;
  static const double bigTextSize = 18;
  static const double lagerTextSize = 30;
}

///文本样式
class AppTextStyles {
  static const normalTextActionWhite = TextStyle(
    color: AppColors.actionBlue,
    fontSize: Dimens.normalTextSize,
  );

  static const minText = TextStyle(
    color: AppColors.subLightTextColor,
    fontSize: Dimens.minTextSize,
  );

  static const smallTextWhite = TextStyle(
    color: AppColors.textColorWhite,
    fontSize: Dimens.smallTextSize,
  );

  static const smallText = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: Dimens.smallTextSize,
  );

  static const smallTextBold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: Dimens.smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = TextStyle(
    color: AppColors.subLightTextColor,
    fontSize: Dimens.smallTextSize,
  );

  static const smallActionLightText = TextStyle(
    color: AppColors.actionBlue,
    fontSize: Dimens.smallTextSize,
  );

  static const smallMiLightText = TextStyle(
    color: AppColors.miWhite,
    fontSize: Dimens.smallTextSize,
  );

  static const smallSubText = TextStyle(
    color: AppColors.subTextColor,
    fontSize: Dimens.smallTextSize,
  );

  static const middleText = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: Dimens.middleTextSize,
  );

  static const middleTextWhite = TextStyle(
    color: AppColors.textColorWhite,
    fontSize: Dimens.middleTextSize,
  );

  static const middleSubText = TextStyle(
    color: AppColors.subTextColor,
    fontSize: Dimens.middleTextSize,
  );

  static const middleSubLightText = TextStyle(
    color: AppColors.subLightTextColor,
    fontSize: Dimens.middleTextSize,
  );

  static const middleTextBold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: Dimens.middleTextSize,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = TextStyle(
    color: AppColors.textColorWhite,
    fontSize: Dimens.middleTextSize,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = TextStyle(
    color: AppColors.subTextColor,
    fontSize: Dimens.middleTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalText = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: Dimens.normalTextSize,
  );

  static const normalTextBold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: Dimens.normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalSubText = TextStyle(
    color: AppColors.subTextColor,
    fontSize: Dimens.normalTextSize,
  );

  static const normalTextWhite = TextStyle(
    color: AppColors.textColorWhite,
    fontSize: Dimens.normalTextSize,
  );

  static const normalTextMitWhiteBold = TextStyle(
    color: AppColors.miWhite,
    fontSize: Dimens.normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextActionWhiteBold = TextStyle(
    color: AppColors.actionBlue,
    fontSize: Dimens.normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = TextStyle(
    color: AppColors.primaryLightValue,
    fontSize: Dimens.normalTextSize,
  );

  static const largeText = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: Dimens.bigTextSize,
  );

  static const largeTextBold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: Dimens.bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextWhite = TextStyle(
    color: AppColors.textColorWhite,
    fontSize: Dimens.bigTextSize,
  );

  static const largeTextWhiteBold = TextStyle(
    color: AppColors.textColorWhite,
    fontSize: Dimens.bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = TextStyle(
    color: AppColors.textColorWhite,
    fontSize: Dimens.lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeText = TextStyle(
    color: AppColors.primaryColor,
    fontSize: Dimens.lagerTextSize,
    fontWeight: FontWeight.bold,
  );
  static final tsW700 = TextStyle(
      color: AppColors.c333333,
      fontWeight: FontWeight.w700,
      fontSize: Dimens.middleTextSize.sp);

  static final tsW900 = TextStyle(
      color: AppColors.c333333,
      fontWeight: FontWeight.w900,
      fontSize: Dimens.middleTextSize.sp);

  static final tsW400 = TextStyle(
    color: AppColors.c333333,
    fontWeight: FontWeight.w400,
    fontSize: Dimens.middleTextSize.sp,
  );

  static final tsW400F12 = TextStyle(
      color: AppColors.c202020,
      fontWeight: FontWeight.w400,
      fontSize: Dimens.small1TextSize.sp);
}

///颜色
class AppColors {
  static const Color primaryColor = Color(0xFF8960FF);
  static const Color primary1Color = Color(0xFFA192FF);
  static const Color primaryLightValue = Color(0xFF42464b);
  static const Color primaryDarkValue = Color(0xFF121917);

  static const Color cardWhite = Colors.white;
  static const Color textWhite = Colors.white;
  static const Color miWhite = Color(0xffececec);
  static const Color white = Colors.white;
  static const Color actionBlue = Color(0xff267aff);
  static const Color subTextColor = Color(0xff959595);
  static const Color subLightTextColor = Color(0xffc4c4c4);
  static const Color mainBackgroundColor = miWhite;
  static const Color mainTextColor = primaryDarkValue;
  static const Color textColorWhite = white;

  static const Color cA9A9A9 = Color(0xFFA9A9A9);
  static const Color cBBBBBB = Color(0xFFBBBBBB);
  static const Color cB8B8B8 = Color(0xFFB8B8B8);
  static const Color c999999 = Color(0xFF999999);
  static const Color cF0F0F0 = Color(0xFFF0F0F0);
  static const Color cAC6BFF = Color(0xFFAC6BFF);
  static const Color c666666 = Color(0xFF666666);
  static const Color c892CFF = Color(0xFF892CFF);
  static const Color cF4EAFF = Color(0xFFF4EAFF);
  static const Color c7635FF = Color(0xFF7635FF);
  static const Color cC0C0C0 = Color(0xFFC0C0C0);
  static const Color c202020 = Color(0xFF202020);
  static const Color cF6F1FF = Color(0xFFF6F1FF);
  static const Color cEFF0FF = Color(0xFFEFF0FF);
  static const Color c8423FF = Color(0xFF8423FF);
  static const Color c333333 = Color(0xFF333333);
  static const Color c565656 = Color(0xFF565656);
  static const Color cC7C7C7 = Color(0xFFC7C7C7);
  static const Color cF8F8F8 = Color(0xFFF8F8F8);
  static const Color cB881FF = Color(0xFFB881FF);
  static const Color cFF9C40 = Color(0xFFFF9C40);
  static const Color cFF4F79 = Color(0xFFFF4F79);
  static const Color cFBF9FF = Color(0xFFFBF9FF);
  static const Color cFAF6FF = Color(0xFFFAF6FF);
  static const Color c8B30FF = Color(0xFF8B30FF);
  static const Color cFFE39C = Color(0xFFFFE39C);
  static const Color c0BD3FF = Color(0xFF0BD3FF);
  static const Color c9846FF = Color(0xFF9846FF);
  static const Color cFF698D = Color(0xFFFF698D);
  static const Color cFFE9EE = Color(0xFFFFE9EE);
  static const Color cE9D7FF = Color(0xFFE9D7FF);
  static const Color cFC7BFF = Color(0xFFFC7BFF);
  static const Color cA258FF = Color(0xFFA258FF);
  static const Color cBDB6C7 = Color(0xFFBDB6C7);
  static const Color cFFD66C = Color(0xFFFFD66C);
  static const Color cFF715D = Color(0xFFFF715D);
  static const Color cFF4B77 = Color(0xFFFF4B77);
  static const Color cFFFF4B77 = Color(0xFFFF4B77);
  static const Color c4C2BA8 = Color(0xFF4C2BA8);
  static const Color c92E5FF = Color(0xFF92E5FF);
  static const Color cC89CFF = Color(0xFFC89CFF);
  static const Color cFF6257 = Color(0xFFFF6257);
  static const Color cFFE5BF = Color(0xFFFFE5BF);
  static const Color cFFAD80 = Color(0xFFFFAD80);
  static const Color cCBA3FF = Color(0xFFCBA3FF);
  static const Color cEEDDFF = Color(0xFFEEDDFF);
  static const Color c02F0FF = Color(0xFF02F0FF);
  static const Color c963EFC = Color(0xFF963EFC);
  static const Color cFCFAFF = Color(0xFFFCFAFF);
  static const Color cFFF4F4 = Color(0xFFFFF4F4);

  ///fantasy sport
  static const Color cCE1414 = Color(0xFFCE1414);
  static const Color cE10004 = Color(0xFFE10004);
  static const Color cD3D3D3 = Color(0xFFD3D3D3);
  static const Color c0E9E3A = Color(0xFF0E9E3A);
  static const Color c119F3B = Color(0xFF119F3B);
  static const Color c42536D = Color(0xFF42536D);
  static const Color c89DC9D = Color(0xFF89DC9D);
  static const Color cD9D9D9 = Color(0xFFD9D9D9);
  static const Color cD2DCE9 = Color(0xFFD2DCE9);
  static const Color c222222 = Color(0xFF222222);
  static const Color cFDDEDF = Color(0xFFFDDEDF);
  static const Color cFAE4D9 = Color(0xFFFAE4D9);
  static const Color cFF5000 = Color(0xFFFF5000);
  static const Color cFFF6E4 = Color(0xFFFFF6E4);
  static const Color c0E8931 = Color(0xFF0E8931);
  static const Color c2967B2 = Color(0xFF2967B2);
  static const Color c555555 = Color(0xFF555555);
  static const Color cFEF5E4 = Color(0xFFFEF5E4);
  static const Color cFFF7F8 = Color(0xFFFFF7F8);
  static const Color cF5F5F5 = Color(0xFFF5F5F5);
  static const Color c01791E = Color(0xFF01791E);
  static const Color c00811F = Color(0xFF00811F);
  static const Color c20D156 = Color(0xFF20D156);
  static const Color cFFC52F = Color(0xFFFFC52F);
  static const Color cFF9901 = Color(0xFFFF9901);
  static const Color cFF9820 = Color(0xFFFF9820);
  static const Color cEE200C = Color(0xFFEE200C);
  static const Color cFFE0AC = Color(0xFFFFE0AC);
  static const Color c976300 = Color(0xFF976300);

  //chat
  static const Color cB57CFF = Color(0xFFB57CFF);
  static const Color c8F00FF = Color(0xFF8F00FF);
  static const Color c180030 = Color(0xFF180030);
  static const Color c2E005B = Color(0xFF2E005B);
  static const Color cA523E2 = Color(0xFFA523E2);
  static const Color c009054 = Color(0xFF009054);
  static const Color cF2F0F3 = Color(0xFFF2F0F3);
  static const Color cA965FF = Color(0xFFA965FF);
  static const Color cCDCDCD = Color(0xFFCDCDCD);
}
