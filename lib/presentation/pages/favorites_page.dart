import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/favorites_cubit.dart';
import '../bloc/pet_list_bloc.dart';
import 'details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  int _getCrossAxisCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 800) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Pets',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: BlocBuilder<FavoritesCubit, Set<String>>(
        builder: (context, favoriteIds) {
          return BlocBuilder<PetListBloc, PetListState>(
            builder: (context, state) {
              if (state is PetListLoaded) {
                final pets = state.pets
                    .where((pet) => favoriteIds.contains(pet.id))
                    .toList();
                if (pets.isEmpty) {
                  return Center(
                    child: Text(
                      'No favorite pets.',
                      style: GoogleFonts.poppins(),
                    ),
                  );
                }
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount =
                        _getCrossAxisCount(constraints.maxWidth);
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: pets.length,
                      itemBuilder: (context, index) {
                        final pet = pets[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsPage(pet: pet),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Hero(
                                          tag: 'petImage_${pet.id}',
                                          child: Image.network(
                                            pet.imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(Icons.pets,
                                                        size: 48),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    pet.name,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Age: ${pet.age} | Price: ₹${pet.price}',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
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
