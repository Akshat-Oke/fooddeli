import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddeli/models/menu_item.dart';

class RestaurantModel {
  //Private constructor
  RestaurantModel._({
    required this.name,
    // this.isOpen = true,
    required this.fromTime,
    required this.toTime,
    required this.docId,
    required this.categories,
  });
  final String name;
  final String docId;
  // final bool isOpen;
  final List<dynamic> categories;

  /// from and to times
  final Timestamp fromTime, toTime;

  bool get isOpen {
    final now = Timestamp.now();
    return fromTime.compareTo(now) < 0 && toTime.compareTo(now) > 0;
  }

  /// Menu items
  List<MenuItem>? items;
  String get fromTimeString {
    final DateTime date = fromTime.toDate();
    final time = TimeOfDay.fromDateTime(date);
    return "${time.hour}:${time.minute}";
  }

  String get toTimeString {
    final DateTime date = toTime.toDate();
    final time = TimeOfDay.fromDateTime(date);
    return "${time.hour}:${time.minute}";
  }

  String times(context) {
    DateTime date = fromTime.toDate();
    TimeOfDay fTime = TimeOfDay(hour: date.hour, minute: date.minute);
    date = toTime.toDate();
    TimeOfDay tTime = TimeOfDay(hour: date.hour, minute: date.minute);
    return ("${fTime.format(context)} - ${tTime.format(context)}");
  }

  factory RestaurantModel.fromJSON(Map<String, dynamic> json) {
    final t = Timestamp(1234134, 0);
    return RestaurantModel._(
      name: json["name"] ?? "Restaurant",
      // isOpen: json["isOpen"] ?? false,
      fromTime: json["fromTime"],
      toTime: json["toTime"],
      docId: json["id"],
      categories: (json["categories"]) ?? [],
    );
  }
}