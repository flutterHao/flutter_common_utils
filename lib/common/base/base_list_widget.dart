import 'package:flutter/material.dart';

class TabItemInfo {
  TabItemInfo(this.defaultTabName, this.tabIconNormal, this.tabIconSelected);
  String defaultTabName;
  String tabIconNormal;
  String tabIconSelected;
}

abstract class AbsBaseComponent extends StatelessWidget {
  const AbsBaseComponent({Key? key, this.extParams}) : super(key: key);
  final Map<String, dynamic>? extParams;
  void dump();
  Map<String, ExtParamInfos> privateExtParams();
  WidgetInfos widgetInfos();
  Map<String, EventInfos> privateDatasourceEvents();
}

class ExtParamInfos {
  static const String dataTypeInt = 'int';
  static const String dataTypeFloat = 'float';
  static const String dataTypeString = 'string';
  static const String dataTypeBool = 'bool';
  static const String dataTypeListString = 'list_string'; // aa,bb,cc
  ExtParamInfos(
      {required this.name,
      required this.description,
      required this.dataType,
      required this.defaultValue,
      required this.paramVersion});
  String name;
  String description;
  String dataType;
  String defaultValue;
  String paramVersion;
}

class WidgetInfos {
  WidgetInfos(
      {required this.name,
      required this.description,
      required this.widgetVersion,
      required this.positionType,
      required this.widgetAllowPlatformType,
      required this.isAllowRepeat,
      required this.isEditable,
      required this.fieldList});
  String name;
  String description;
  String widgetVersion;
  ComponentPositionType positionType;
  WidgetAllowPlatformType widgetAllowPlatformType;
  bool isAllowRepeat;
  bool isEditable;
  List<String> fieldList;
  String dumpString() {
    return 'name: $name, description: $description, widgetVersion: $widgetVersion, isAllowRepeat: $isAllowRepeat, isEditable: $isEditable';
  }
}

class EventInfos {
  EventInfos({required this.extParamInfos});
  Map<String, ExtParamInfos> extParamInfos;
}

class ComponentPositionType {
  static const String positionTypeKey = 'position_type';
  static const String positionTypeValueStatic = 'position_type_static';
  static const String positionTypeValueAbsolute = 'position_type_absolute';
  static const String positionTypeValueFixed = 'position_type_fixed';
  static const String positionTypeValueSliverAppBar =
      'position_type_sliver_app_bar';
  static const String positionTypeValueNotify = 'position_type_notify';
  static const String positionTypeValueTab = 'position_type_tab';
  static const String positionTypeValuePage = 'position_type_page';
  ComponentPositionType(this.positionType);
  String positionType;
}

class WidgetAllowPlatformType {
  static const String widgetAllowPlatformTypeIOS = 'ios';
  static const String widgetAllowPlatformTypeAndroid = 'android';
  static const String widgetAllowPlatformTypeBoth = 'both';
  WidgetAllowPlatformType(this.widgetAllowPlatformType);
  String widgetAllowPlatformType;
}
