import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/models/pet_model.dart';
// THE FIX: Using a package-relative import is more robust
import 'package:pet_adoption_app/presentation/screens/widgets/pet_card.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Pet> favoritePets;
  final Set<int> favoritePetIds;
  final Function(int) onToggleFavorite;

  const FavoritesScreen({
    Key? key,
    required this.favoritePets,
    required this.favoritePetIds,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoritePets.isEmpty) {
      return Center(
        child: Text(
          'You haven\'t favorited any pets yet!',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: favoritePets.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final pet = favoritePets[index];
        return PetCard(
          pet: pet,
          isFavorite: favoritePetIds.contains(pet.id),
          onToggleFavorite: onToggleFavorite,
        );
      },
    );
  }
}

