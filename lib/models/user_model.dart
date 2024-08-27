class User {
  final String id;
  final String? profileImageUrl;
  final String? businessLogo;
  final String? fullname;
  final String? address;
  final String? bornDate;
  final String? email;
  final String? ownerName;
  final String? phone;
  final String? role;
  final String? businessName;
  final String? businessEmail;
  final String? businessAddress;
  final String? businessDescription;

  User({
    required this.id,
    this.profileImageUrl,
    this.fullname,
    this.address,
    this.bornDate,
    this.email,
    this.phone,
    this.role,
    this.businessName,
    this.businessLogo,
    this.businessEmail,
    this.businessAddress,
    this.businessDescription,
    this.ownerName,
  });

  factory User.fromMap(String id, Map<String, dynamic> data) {
    return User(
      id: id,
      profileImageUrl: data['profileImageUrl'],
      fullname: data['fullname'],
      address: data['address'],
      email: data['email'],
      bornDate: data['bornDate'],
      phone: data['phone'],
      role: data['role'],
      businessName: data['business_name'],
      businessEmail: data['business_email'],
      businessLogo: data['business_logo'],
      ownerName: data['owner_name'],
      businessAddress: data['business_address'],
      businessDescription: data['business_description'],
    );
  }
}
