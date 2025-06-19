class Pet {
  final String id;
  final String name;
  final int age;
  final double price;
  final String imageUrl;
  final bool isAdopted;
  final bool isFavorite;

  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.imageUrl,
    this.isAdopted = false,
    this.isFavorite = false,
  });

  Pet copyWith({
    String? id,
    String? name,
    int? age,
    double? price,
    String? imageUrl,
    bool? isAdopted,
    bool? isFavorite,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isAdopted: isAdopted ?? this.isAdopted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
