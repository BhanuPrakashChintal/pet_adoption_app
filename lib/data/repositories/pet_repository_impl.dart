import '../../domain/entities/pet.dart';
import '../../domain/repositories/pet_repository.dart';
import '../datasources/pet_data_source.dart';

class PetRepositoryImpl implements PetRepository {
  final PetDataSource dataSource;

  PetRepositoryImpl(this.dataSource);

  @override
  Future<List<Pet>> getPets() async {
    return await dataSource.fetchPets();
  }
}
