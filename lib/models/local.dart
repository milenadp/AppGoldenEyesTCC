import 'dart:convert';

class Local {
  String street;
  String neighborhood;
  String city;
  String state;
  Local({
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  Local copyWith({
    String? street,
    String? neighborhood,
    String? city,
    String? state,
  }) {
    return Local(
      street: street ?? this.street,
      neighborhood: neighborhood ?? this.neighborhood,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
    };
  }

  factory Local.fromMap(Map<String, dynamic> map) {
    return Local(
      street: map['street'] as String,
      neighborhood: map['neighborhood'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Local.fromJson(String source) =>
      Local.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Local(street: $street, neighborhood: $neighborhood, city: $city, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Local &&
        other.street == street &&
        other.neighborhood == neighborhood &&
        other.city == city &&
        other.state == state;
  }

  @override
  int get hashCode {
    return street.hashCode ^
        neighborhood.hashCode ^
        city.hashCode ^
        state.hashCode;
  }
}
