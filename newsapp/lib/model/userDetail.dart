class UserDetails {
  final String id;
  final String name;
  final String email;
  final String enrollmentNumber;
  final String? section;
  final String? gender;
  final String? profileImage;
  final String role;

  UserDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.enrollmentNumber,
    this.section,
    this.gender,
    this.profileImage,
    this.role = 'Teacher',
  });

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      gender: map["gender"]?.toString() ?? "",
      enrollmentNumber: map['enrollment_number']?.toString() ?? '',
      section: map['section']?.toString(),
      profileImage: map['profile_image']?.toString(),
      role: map['role']?.toString() ?? 'student',
    );
  }
}
