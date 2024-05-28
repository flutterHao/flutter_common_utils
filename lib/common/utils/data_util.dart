import 'package:flutter/foundation.dart';

///@author lihonghao
///@date 2022/6/30
///
typedef SectionViewOnFetchAlphabet<T> = String Function(T header);

// const dataList = [
//   Data("2022-1", "曙光英雄"),
//   Data("2022-1", "曙光英雄"),
//   Data("2022-1", "曙光英雄"),
//   Data("2022-1", "曙光英雄"),
//   Data("2022-1", "曙光英雄"),
//   Data("2022-1", "曙光英雄"),
//   Data("2022-1", "曙光英雄"),
//   Data("2022-1", "曙光英雄"),
//   Data("2022-1", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
//   Data("2022-2", "曙光英雄"),
// ];

class DataUtil {
  static List<dynamic> convertHierarchyToList<T>(List<T> list,
      SectionViewOnFetchAlphabet<T> sectionViewOnFetchAlphabet, bool isClear) {
    List<AlphabetHeader<T>> dataList =
        _convertListToAlphaHeader(list, sectionViewOnFetchAlphabet, isClear);

    List result = [];
    for (var item in dataList) {
      result.add(item);
      for (var subItem in item.items) {
        result.add(subItem);
      }
    }
    return result;
  }

  static final Map<String, List> map = {};

  static List<AlphabetHeader<T>> _convertListToAlphaHeader<T>(List<T> list,
      SectionViewOnFetchAlphabet<T> sectionViewOnFetchAlphabet, bool isClear) {
    if (isClear) {
      map.clear();
    }
    List<AlphabetHeader<T>> results = [];
    for (var item in list) {
      var date = sectionViewOnFetchAlphabet(item);
      if (!map.containsKey(date)) {
        AlphabetHeader<T> header = AlphabetHeader<T>(
          [],
          date,
        );
        results.add(header);
        map[date] = header.items;
      }
      map[date]?.add(item);
    }
    return results;
  }
}

class AlphabetHeader<T> {
  final String name;
  final List<T> items;

  AlphabetHeader(this.items, this.name);
}

class Data {
  final String date;
  final String name;

  const Data(this.date, this.name);
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}

extension Map2StringEx on Map {
  String mapToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "{";
      forEach((key, value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr \"$key\" : $temp,";
        } else if (value is List) {
          result +=
              "\n$indentationStr \"$key\" : ${value.listToStructureString(indentation: indentation + 2)},";
        } else {
          result += "\n$indentationStr \"$key\" : \"$value\",";
        }
      });
      result = result.substring(0, result.length - 1);
      result += indentation == 2 ? "\n}" : "\n${" " * (indentation - 1)}}";
    }

    return result;
  }
}

extension List2StringEx on List {
  String listToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "$indentationStr[";
      forEach((value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr \"$temp\",";
        } else if (value is List) {
          result += value.listToStructureString(indentation: indentation + 2);
        } else {
          result += "\n$indentationStr \"$value\",";
        }
      });
      result = result.substring(0, result.length - 1);
      result += "\n$indentationStr]";
    }

    return result;
  }
}
