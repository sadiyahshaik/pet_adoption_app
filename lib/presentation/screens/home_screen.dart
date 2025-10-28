import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/models/pet_model.dart';
// THE FIX: Using the absolute package import
import 'package:pet_adoption_app/presentation/screens/widgets/pet_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Pet> pets;
  final Set<int> favoritePetIds;
  final Function(int) onToggleFavorite;

  const HomeScreen({
    Key? key,
    required this.pets,
    required this.favoritePetIds,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: AnimationLimiter(
        child: GridView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: pets.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (BuildContext context, int index) {
            final pet = pets[index];
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: 2,
              child: ScaleAnimation(
                delay: const Duration(milliseconds: 100),
                child: FadeInAnimation(
                  child: PetCard(
                    pet: pet,
                    isFavorite: favoritePetIds.contains(pet.id),
                    onToggleFavorite: onToggleFavorite,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

