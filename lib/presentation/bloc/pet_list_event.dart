part of 'pet_list_bloc.dart';

abstract class PetListEvent extends Equatable {
  const PetListEvent();

  @override
  List<Object?> get props => [];
}

class LoadPetsEvent extends PetListEvent {
  final bool refresh;
  final int page;
  final int pageSize;
  const LoadPetsEvent({this.refresh = false, this.page = 1, this.pageSize = 5});

  @override
  List<Object?> get props => [refresh, page, pageSize];
}

class LoadMorePetsEvent extends PetListEvent {
  final int page;
  final int pageSize;
  const LoadMorePetsEvent({required this.page, this.pageSize = 5});

  @override
  List<Object?> get props => [page, pageSize];
}

class RefreshPetsEvent extends PetListEvent {}
