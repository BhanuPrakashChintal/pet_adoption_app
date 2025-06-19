import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/adoption_cubit.dart';
import '../bloc/pet_list_bloc.dart';
import 'details_page.dart';
import '../../domain/entities/pet.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption History'),
      ),
      body: BlocBuilder<AdoptionCubit, Map<String, String>>(
        builder: (context, adoptedMap) {
          final history = context.read<AdoptionCubit>().adoptionHistory;
          return BlocBuilder<PetListBloc, PetListState>(
            builder: (context, state) {
              if (state is PetListLoaded) {
                final pets = state.pets;
                final adoptedPets = history
                    .map((entry) =>
                        pets.where((pet) => pet.id == entry.key).toList())
                    .where((list) => list.isNotEmpty)
                    .map((list) => list.first)
                    .toList();
                if (adoptedPets.isEmpty) {
                  return const Center(child: Text('No adopted pets yet.'));
                }
                return ListView.builder(
                  itemCount: adoptedPets.length,
                  itemBuilder: (context, index) {
                    final pet = adoptedPets[index];
                    final adoptedAt = DateTime.parse(history[index].value);
                    return ListTile(
                      leading: Hero(
                        tag: 'petImage_${pet.id}',
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(pet.imageUrl),
                        ),
                      ),
                      title: Text(pet.name),
                      subtitle: Text(
                          'Adopted on: ${adoptedAt.toLocal().toString().split(".")[0]}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsPage(pet: pet),
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (state is PetListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PetListError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
