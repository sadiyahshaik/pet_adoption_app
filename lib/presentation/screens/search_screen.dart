import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/models/pet_model.dart';
// THE FIX: Using a package-relative import is more robust
import 'package:pet_adoption_app/presentation/screens/widgets/pet_card.dart';

class SearchScreen extends StatelessWidget {
  final List<Pet> searchResults;
  final Set<int> favoritePetIds;
  final Function(int) onToggleFavorite;
  final Function(String) onSearchChanged;

  const SearchScreen({
    Key? key,
    required this.searchResults,
    required this.favoritePetIds,
    required this.onToggleFavorite,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search by name or breed...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        Expanded(
          child: searchResults.isEmpty
              ? Center(
                  child: Text(
                    'No pets found.',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(12.0),
                  itemCount: searchResults.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final pet = searchResults[index];
                    return PetCard(
                      pet: pet,
                      isFavorite: favoritePetIds.contains(pet.id),
                      onToggleFavorite: onToggleFavorite,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

