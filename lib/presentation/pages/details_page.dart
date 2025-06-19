import 'package:flutter/material.dart';
import '../../domain/entities/pet.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/adoption_cubit.dart';
import '../bloc/favorites_cubit.dart';
import 'package:confetti/confetti.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatefulWidget {
  final Pet pet;
  const DetailsPage({super.key, required this.pet});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _showAdoptedDialog(BuildContext context) {
    _confettiController.play();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: const EdgeInsets.all(16),
        content: Stack(
          alignment: Alignment.center,
          children: [
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.05,
              numberOfParticles: 30,
              maxBlastForce: 20,
              minBlastForce: 8,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Adoption Successful!',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("You've now adopted ${widget.pet.name}"),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pet = widget.pet;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pet.name,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              padding: const EdgeInsets.all(24),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: _PetImage(pet: pet),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          flex: 4,
                          child: _PetInfoCard(
                            pet: pet,
                            theme: theme,
                            confettiController: _confettiController,
                            onAdopted: () => _showAdoptedDialog(context),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _PetImage(pet: pet),
                        const SizedBox(height: 24),
                        _PetInfoCard(
                          pet: pet,
                          theme: theme,
                          confettiController: _confettiController,
                          onAdopted: () => _showAdoptedDialog(context),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _PetImage extends StatelessWidget {
  final Pet pet;
  const _PetImage({required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            child: SizedBox(
              height: 400,
              child: PhotoView(
                imageProvider: NetworkImage(pet.imageUrl),
                heroAttributes:
                    PhotoViewHeroAttributes(tag: 'petImage_${pet.id}'),
              ),
            ),
          ),
        );
      },
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: Hero(
              tag: 'petImage_${pet.id}',
              child: Image.network(
                pet.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.pets, size: 80),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PetInfoCard extends StatelessWidget {
  final Pet pet;
  final ThemeData theme;
  final ConfettiController confettiController;
  final VoidCallback onAdopted;
  const _PetInfoCard({
    required this.pet,
    required this.theme,
    required this.confettiController,
    required this.onAdopted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BlocBuilder<FavoritesCubit, Set<String>>(
                  builder: (context, favoriteIds) {
                    final isFavorite = favoriteIds.contains(pet.id);
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                        size: 28,
                      ),
                      onPressed: () {
                        context.read<FavoritesCubit>().toggleFavorite(pet.id);
                      },
                    );
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  pet.name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Age: ${pet.age}', style: GoogleFonts.poppins(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Price: ₹${pet.price}',
                style: GoogleFonts.poppins(fontSize: 18)),
            const SizedBox(height: 24),
            BlocBuilder<AdoptionCubit, Map<String, String>>(
              builder: (context, adoptedMap) {
                final isAdopted = adoptedMap.containsKey(pet.id);
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: isAdopted
                      ? null
                      : () async {
                          await context.read<AdoptionCubit>().adoptPet(pet.id);
                          if (context.mounted) {
                            onAdopted();
                          }
                        },
                  child: Text(
                    isAdopted ? 'Already Adopted' : 'Adopt Me',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
