class Contact {
  final int id;
  final String name;
  final String phoneNumber;

  const Contact({
    required this.id,
    required this.name,
    required this.phoneNumber
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
    );
  }
}