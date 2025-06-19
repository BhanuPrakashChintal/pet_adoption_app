import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/pet_list_bloc.dart';
import '../bloc/adoption_cubit.dart';
import '../bloc/favorites_cubit.dart';
import 'details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String searchQuery = '';
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

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
          'Pet Adoption Home',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        color: theme.colorScheme.background,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: GoogleFonts.poppins(),
                decoration: InputDecoration(
                  hintText: 'Search pets by name...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: theme.cardColor.withOpacity(0.9),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: BlocConsumer<PetListBloc, PetListState>(
                listener: (context, state) {
                  if (state is PetListLoaded) {
                    _refreshController.refreshCompleted();
                    _refreshController.loadComplete();
                  } else if (state is PetListError) {
                    _refreshController.refreshFailed();
                    _refreshController.loadFailed();
                  }
                },
                builder: (context, state) {
                  if (state is PetListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PetListLoaded) {
                    final pets =
                        state.pets
                            .where(
                              (pet) => pet.name.toLowerCase().contains(
                                searchQuery.toLowerCase(),
                              ),
                            )
                            .toList();
                    if (pets.isEmpty) {
                      return Center(
                        child: Text(
                          'No pets found.',
                          style: GoogleFonts.poppins(),
                        ),
                      );
                    }
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final crossAxisCount = _getCrossAxisCount(
                          constraints.maxWidth,
                        );
                        return SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: true,
                          enablePullUp: !state.hasReachedMax,
                          onRefresh: () {
                            context.read<PetListBloc>().refresh();
                          },
                          onLoading: () {
                            context.read<PetListBloc>().loadMore();
                          },
                          child: BlocBuilder<
                            AdoptionCubit,
                            Map<String, String>
                          >(
                            builder: (context, adoptedMap) {
                              return BlocBuilder<FavoritesCubit, Set<String>>(
                                builder: (context, favoriteIds) {
                                  return GridView.builder(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 8,
                                    ),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: crossAxisCount,
                                          crossAxisSpacing: 24,
                                          mainAxisSpacing: 24,
                                          childAspectRatio: 0.8,
                                        ),
                                    itemCount: pets.length,
                                    itemBuilder: (context, index) {
                                      final pet = pets[index];
                                      final isAdopted = adoptedMap.containsKey(
                                        pet.id,
                                      );
                                      final isFavorite = favoriteIds.contains(
                                        pet.id,
                                      );
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (_) => DetailsPage(pet: pet),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          color:
                                              isAdopted
                                                  ? theme.disabledColor
                                                      .withOpacity(0.15)
                                                  : theme.cardColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Expanded(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                    child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Hero(
                                                        tag:
                                                            'petImage_${pet.id}',
                                                        child: Image.network(
                                                          pet.imageUrl,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) => const Icon(
                                                                Icons.pets,
                                                                size: 48,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        pet.name,
                                                        style: GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color:
                                                              isAdopted
                                                                  ? Colors.grey
                                                                  : null,
                                                          decoration:
                                                              isAdopted
                                                                  ? TextDecoration
                                                                      .lineThrough
                                                                  : null,
                                                        ),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        isFavorite
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color:
                                                            isFavorite
                                                                ? Colors.red
                                                                : Colors.grey,
                                                      ),
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                              FavoritesCubit
                                                            >()
                                                            .toggleFavorite(
                                                              pet.id,
                                                            );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'Age: ${pet.age} | Price: ₹${pet.price}',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                if (isAdopted)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          top: 6.0,
                                                        ),
                                                    child: Text(
                                                      'Already Adopted',
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is PetListError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
