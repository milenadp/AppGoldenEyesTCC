import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'register.dart';

class Dog {
  String id;
  String name;
  String breed;
  String sex;
  String color;
  int birth;
  String control_number;
  List<Register> register_list;
  String img;
  Dog({
    required this.id,
    required this.name,
    required this.breed,
    required this.sex,
    required this.color,
    required this.birth,
    required this.control_number,
    required this.register_list,
    required this.img,
  });

  Dog copyWith({
    String? id,
    String? name,
    String? breed,
    String? sex,
    String? color,
    int? birth,
    String? control_number,
    List<Register>? register_list,
    String? img,
  }) {
    return Dog(
      id: id ?? this.id,
      name: name ?? this.name,
      breed: breed ?? this.breed,
      sex: sex ?? this.sex,
      color: color ?? this.color,
      birth: birth ?? this.birth,
      control_number: control_number ?? this.control_number,
      register_list: register_list ?? this.register_list,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'breed': breed,
      'sex': sex,
      'color': color,
      'birth': birth,
      'control_number': control_number,
      'register_list': register_list.map((x) => x.toMap()).toList(),
      'img': img,
    };
  }

  factory Dog.fromMap(Map<String, dynamic> map) {
      return Dog(
      id: map['id'] as String,
      name: map['name'] as String,
      breed: map['breed'] as String,
      sex: map['sex'] as String,
      color: map['color'] as String,
      birth: map['birth'] as int,
      control_number: map['control_number'] as String,
      register_list: List<Register>.from(
          map['register_list']?.map((x) => Register.fromMap(x))),
      img: map['img'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dog.fromJson(String source) =>
      Dog.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Dog(id: $id, name: $name, breed: $breed, sex: $sex, color: $color, birth: $birth, control_number: $control_number, register_list: $register_list, img: $img)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Dog &&
        other.id == id &&
        other.name == name &&
        other.breed == breed &&
        other.sex == sex &&
        other.color == color &&
        other.birth == birth &&
        other.control_number == control_number &&
        listEquals(other.register_list, register_list) &&
        other.img == img;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        breed.hashCode ^
        sex.hashCode ^
        color.hashCode ^
        birth.hashCode ^
        control_number.hashCode ^
        register_list.hashCode ^
        img.hashCode;
  }
}
