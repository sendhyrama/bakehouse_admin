class User {
  final String? profileImageUrl;
  final String? businessLogo;
  final String? fullname;
  final String? email;
  final String? phone;
  final String? role;
  final String? businessName;
  final String? businessEmail;

  User({
    this.profileImageUrl,
    this.fullname,
    this.email,
    this.phone,
    this.role,
    this.businessName,
    this.businessLogo,
    this.businessEmail,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      profileImageUrl: data['profileImageUrl'],
      fullname: data['fullname'],
      email: data['email'],
      phone: data['phone'],
      role: data['role'],
      businessName: data['business_name'],
      businessEmail: data['business_email'],
      businessLogo: data['business_logo'],
    );
  }
}
