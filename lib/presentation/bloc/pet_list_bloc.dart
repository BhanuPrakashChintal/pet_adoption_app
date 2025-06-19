import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/pet.dart';
import '../../domain/usecases/get_pets.dart';
import 'package:equatable/equatable.dart';

part 'pet_list_event.dart';
part 'pet_list_state.dart';

class PetListBloc extends Bloc<PetListEvent, PetListState> {
  final GetPets getPets;
  List<Pet> _allPets = [];
  int _currentPage = 1;
  final int _pageSize = 5;

  PetListBloc(this.getPets) : super(PetListInitial()) {
    on<LoadPetsEvent>((event, emit) async {
      emit(PetListLoading());
      try {
        final pets = await getPets();
        emit(PetListLoaded(pets));
      } catch (e) {
        emit(PetListError('Failed to load pets'));
      }
    });
  }

  void loadMore() {
    if (state is PetListLoaded && !(state as PetListLoaded).hasReachedMax) {
      add(LoadMorePetsEvent(page: _currentPage + 1, pageSize: _pageSize));
    }
  }

  void refresh() {
    add(RefreshPetsEvent());
  }
}
