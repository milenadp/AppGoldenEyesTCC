import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:golden_eyes/models/activity.dart';
import 'local.dart';

class Register {
  String id;
  List<Activity> activity_list;
  int date;
  String dog_id;
  String user_id;
  String description;
  Local local;
  Register({
    required this.id,
    required this.activity_list,
    required this.date,
    required this.dog_id,
    required this.user_id,
    required this.description,
    required this.local,
  });

  Register copyWith({
    String? id,
    List<Activity>? activity_list,
    int? date,
    String? dog_id,
    String? user_id,
    String? description,
    Local? local,
  }) {
    return Register(
      id: id ?? this.id,
      activity_list: activity_list ?? this.activity_list,
      date: date ?? this.date,
      dog_id: dog_id ?? this.dog_id,
      user_id: user_id ?? this.user_id,
      description: description ?? this.description,
      local: local ?? this.local,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'activity_list': activity_list.map((x) => x.toMap()).toList(),
      'date': date,
      'dog_id': dog_id,
      'user_id': user_id,
      'description': description,
      'local': local.toMap(),
    };
  }

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      id: map['id'] as String,
      activity_list: List<Activity>.from(
        (map['activity_list'] as List<int>).map<Activity>(
          (x) => Activity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      date: map['date'] as int,
      dog_id: map['dog_id'] as String,
      user_id: map['user_id'] as String,
      description: map['description'] as String,
      local: Local.fromMap(map['local'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Register.fromJson(String source) =>
      Register.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Register(id: $id, activity_list: $activity_list, date: $date, dog_id: $dog_id, user_id: $user_id, description: $description, local: $local)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Register &&
        other.id == id &&
        listEquals(other.activity_list, activity_list) &&
        other.date == date &&
        other.dog_id == dog_id &&
        other.user_id == user_id &&
        other.description == description &&
        other.local == local;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        activity_list.hashCode ^
        date.hashCode ^
        dog_id.hashCode ^
        user_id.hashCode ^
        description.hashCode ^
        local.hashCode;
  }
}
