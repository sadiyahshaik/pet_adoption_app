import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/models/pet_model.dart';
import 'adoption_form_screen.dart';

class DetailsScreen extends StatelessWidget {
  final Pet pet;
  const DetailsScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow body to go behind transparent app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.4),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Hero Image
          Hero(
            tag: 'pet-image-${pet.id}',
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5, // Take half screen height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(pet.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Content Scrollable Area
          DraggableScrollableSheet(
            initialChildSize: 0.6, // Start from 60% of the screen
            minChildSize: 0.6,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                pet.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                            Text(
                              '${pet.age} years old',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        child: Text(
                          pet.breed,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.deepPurple.shade300,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: Text(
                          'About ${pet.name}',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeInUp(
                        delay: const Duration(milliseconds: 500),
                        child: Text(
                          pet.description,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.black87.withOpacity(0.8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100), // More space before button
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Pulse( // Pulsing animation for the button
        delay: const Duration(milliseconds: 700),
        duration: const Duration(seconds: 2),
        infinite: true,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AdoptionFormScreen(),
            ));
          },
          label: Text('ADOPT ME', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
          icon: const Icon(Icons.pets, size: 28),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          extendedPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 8,
        ),
      ),
    );
  }
}

