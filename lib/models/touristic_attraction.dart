class TouristicAttraction {
  final String id;
  final String name;

  TouristicAttraction({required this.id, required this.name});

  factory TouristicAttraction.fromJson(Map<String, dynamic> json) {
    return TouristicAttraction(
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