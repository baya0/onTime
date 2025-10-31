import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required int id,
    required String firstName,
    required String lastName,
    required String phone,
    required int cityId,
  }) : super(id: id, firstName: firstName, lastName: lastName, phone: phone, cityId: cityId);

  // Convert JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      cityId: json['city_id'],
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'city_id': cityId,
    };
  }
}
