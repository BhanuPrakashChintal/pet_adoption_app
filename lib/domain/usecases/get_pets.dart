import '../entities/pet.dart';
import '../repositories/pet_repository.dart';

class GetPets {
  final PetRepository repository;

  GetPets(this.repository);

  Future<List<Pet>> call() async {
    return await repository.getPets();
  }
}
