part of 'pet_list_bloc.dart';

abstract class PetListState extends Equatable {
  const PetListState();

  @override
  List<Object?> get props => [];
}

class PetListInitial extends PetListState {}

class PetListLoading extends PetListState {}

class PetListLoaded extends PetListState {
  final List<Pet> pets;
  final bool hasReachedMax;
  const PetListLoaded(this.pets, {this.hasReachedMax = false});

  PetListLoaded copyWith({List<Pet>? pets, bool? hasReachedMax}) {
    return PetListLoaded(
      pets ?? this.pets,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [pets, hasReachedMax];
}

class PetListError extends PetListState {
  final String message;
  const PetListError(this.message);

  @override
  List<Object?> get props => [message];
}
