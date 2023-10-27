class ContactModel {
  final String imageUrl;
  final String name;
  final String number;
  final int id;

  ContactModel({
    required this.name,
    required this.imageUrl,
    required this.number,
    required this.id,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    name: json['name'],
    imageUrl: json['url'],
    number: json['number'],
    id: json['id'],
  );
}