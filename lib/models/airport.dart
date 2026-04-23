class Airport {
  final String id;
  final String name;

  Airport({required this.id, required this.name});

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      id: json['id'].toString(),
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}