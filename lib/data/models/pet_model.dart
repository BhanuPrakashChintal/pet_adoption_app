import '../../domain/entities/pet.dart';

class PetModel extends Pet {
  PetModel({
    required String id,
    required String name,
    required int age,
    required double price,
    required String imageUrl,
    bool isAdopted = false,
    bool isFavorite = false,
  }) : super(
          id: id,
          name: name,
          age: age,
          price: price,
          imageUrl: imageUrl,
          isAdopted: isAdopted,
          isFavorite: isFavorite,
        );

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      isAdopted: json['isAdopted'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'price': price,
      'imageUrl': imageUrl,
      'isAdopted': isAdopted,
      'isFavorite': isFavorite,
    };
  }
}
