import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/data/models/pet_model.dart';

void main() {
  group('PetModel', () {
    test('fromJson and toJson', () {
      final json = {
        'id': '1',
        'name': 'Bella',
        'age': 2,
        'price': 120.0,
        'imageUrl':
            'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg',
        'isAdopted': true,
        'isFavorite': false,
      };
      final pet = PetModel.fromJson(json);
      expect(pet.id, '1');
      expect(pet.name, 'Bella');
      expect(pet.age, 2);
      expect(pet.price, 120.0);
      expect(pet.imageUrl,
          'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg');
      expect(pet.isAdopted, true);
      expect(pet.isFavorite, false);
      expect(pet.toJson(), json);
    });
  });
}
