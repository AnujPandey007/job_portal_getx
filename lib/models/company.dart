class Company {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  Company({required this.id, required this.name, required this.description, required this.imageUrl});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['title'].split(' ').take(2).join(' '),
      description: json['title'],
      imageUrl: json['thumbnailUrl'],
    );
  }
}
