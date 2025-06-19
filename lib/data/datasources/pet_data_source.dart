import '../models/pet_model.dart';

class PetDataSource {
  static List<Map<String, dynamic>> mockPetData = [
    {
      'id': '1',
      'name': 'Bella',
      'age': 2,
      'price': 120.0,
      'imageUrl':
          'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg',
    },
    {
      'id': '2',
      'name': 'Charlie',
      'age': 3,
      'price': 150.0,
      'imageUrl':
          'https://images.pexels.com/photos/4587997/pexels-photo-4587997.jpeg',
    },
    {
      'id': '3',
      'name': 'Luna',
      'age': 1,
      'price': 100.0,
      'imageUrl':
          'https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg',
    },
    {
      'id': '4',
      'name': 'Max',
      'age': 4,
      'price': 200.0,
      'imageUrl':
          'https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg',
    },
    {
      'id': '5',
      'name': 'Lucy',
      'age': 2,
      'price': 130.0,
      'imageUrl':
          'https://images.pexels.com/photos/1170986/pexels-photo-1170986.jpeg',
    },
    {
      'id': '6',
      'name': 'Daisy',
      'age': 5,
      'price': 90.0,
      'imageUrl':
          'https://images.pexels.com/photos/164186/pexels-photo-164186.jpeg',
    },
    {
      'id': '7',
      'name': 'Milo',
      'age': 3,
      'price': 110.0,
      'imageUrl':
          'https://images.pexels.com/photos/979247/pexels-photo-979247.jpeg',
    },
    {
      'id': '8',
      'name': 'Rocky',
      'age': 2,
      'price': 140.0,
      'imageUrl':
          'https://images.pexels.com/photos/1805164/pexels-photo-1805164.jpeg',
    },
    {
      'id': '9',
      'name': 'Coco',
      'age': 1,
      'price': 160.0,
      'imageUrl':
          'https://images.pexels.com/photos/45243/kitty-cat-kitten-pet-45243.jpeg',
    },
    {
      'id': '10',
      'name': 'Buddy',
      'age': 4,
      'price': 170.0,
      'imageUrl':
          'https://images.pexels.com/photos/460775/pexels-photo-460775.jpeg',
    },
    {
      'id': '11',
      'name': 'Simba',
      'age': 2,
      'price': 180.0,
      'imageUrl':
          'https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg',
    },
    {
      'id': '12',
      'name': 'Oliver',
      'age': 3,
      'price': 125.0,
      'imageUrl':
          'https://images.pexels.com/photos/416160/pexels-photo-416160.jpeg',
    },
    {
      'id': '13',
      'name': 'Nala',
      'age': 2,
      'price': 135.0,
      'imageUrl':
          'https://images.pexels.com/photos/45202/kitty-cat-kitten-pet-45202.jpeg',
    },
    {
      'id': '14',
      'name': 'Bailey',
      'age': 1,
      'price': 145.0,
      'imageUrl':
          'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg',
    },
    {
      'id': '15',
      'name': 'Lily',
      'age': 4,
      'price': 155.0,
      'imageUrl':
          'https://images.pexels.com/photos/4587997/pexels-photo-4587997.jpeg',
    },
    {
      'id': '16',
      'name': 'Toby',
      'age': 2,
      'price': 165.0,
      'imageUrl':
          'https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg',
    },
    {
      'id': '17',
      'name': 'Chloe',
      'age': 3,
      'price': 175.0,
      'imageUrl':
          'https://images.pexels.com/photos/1170986/pexels-photo-1170986.jpeg',
    },
    {
      'id': '18',
      'name': 'Oscar',
      'age': 5,
      'price': 185.0,
      'imageUrl':
          'https://images.pexels.com/photos/164186/pexels-photo-164186.jpeg',
    },
    {
      'id': '19',
      'name': 'Ruby',
      'age': 1,
      'price': 195.0,
      'imageUrl':
          'https://images.pexels.com/photos/979247/pexels-photo-979247.jpeg',
    },
    {
      'id': '20',
      'name': 'Jack',
      'age': 2,
      'price': 205.0,
      'imageUrl':
          'https://images.pexels.com/photos/1805164/pexels-photo-1805164.jpeg',
    },
    {
      'id': '21',
      'name': 'Bunny',
      'age': 1,
      'price': 80.0,
      'imageUrl':
          'https://images.pexels.com/photos/326012/pexels-photo-326012.jpeg',
    },
    {
      'id': '22',
      'name': 'Tweety',
      'age': 2,
      'price': 60.0,
      'imageUrl':
          'https://images.pexels.com/photos/45911/peacock-bird-plumage-color-45911.jpeg',
    },
    {
      'id': '23',
      'name': 'Hammy',
      'age': 1,
      'price': 50.0,
      'imageUrl':
          'https://images.pexels.com/photos/325490/pexels-photo-325490.jpeg',
    },
    {
      'id': '24',
      'name': 'Shadow',
      'age': 4,
      'price': 210.0,
      'imageUrl':
          'https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg',
    },
    {
      'id': '25',
      'name': 'Sunny',
      'age': 2,
      'price': 220.0,
      'imageUrl':
          'https://images.pexels.com/photos/45243/kitty-cat-kitten-pet-45243.jpeg',
    },
  ];

  Future<List<PetModel>> fetchPets() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockPetData.map((json) => PetModel.fromJson(json)).toList();
  }
}
