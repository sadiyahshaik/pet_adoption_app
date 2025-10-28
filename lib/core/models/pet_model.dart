// lib/core/models/pet_model.dart

class Pet {
  final int id;
  final String name;
  final String imageUrl;
  final String breed;
  final int age;
  final String description;

  Pet({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.breed,
    required this.age,
    required this.description,
  });
}