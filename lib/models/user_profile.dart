import 'package:flutter/foundation.dart';

class UserProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final String nic;
  final bool isMauritianResident;
  final DateTime createdAt;

  const UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    required this.nic,
    required this.isMauritianResident,
    required this.createdAt,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      nic: map['nic'] as String,
      isMauritianResident: map['is_mauritian_resident'] as bool? ?? false,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'nic': nic,
      'is_mauritian_resident': isMauritianResident,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfile &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phone == phone &&
        other.nic == nic &&
        other.isMauritianResident == isMauritianResident &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => hashValues(id, firstName, lastName, email, phone, nic,
      isMauritianResident, createdAt);
}
