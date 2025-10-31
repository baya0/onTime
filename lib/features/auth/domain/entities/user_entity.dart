class UserEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final int cityId;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.cityId,
  });

  // Helper getters
  String get fullName => '$firstName $lastName';
}
