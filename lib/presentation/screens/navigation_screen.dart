import 'package:flutter/material.dart'; // <-- THE FIX: Was 'package.flutter/material.dart'
import 'package:google_fonts/google_fonts.dart';

// Import all the screens
import 'home_screen.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';

import '../../core/models/pet_model.dart'; // Import pet model

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  String _searchQuery = '';

  // --- MOCK DATA & STATE ---
  // This is now the "single source of truth" for our data
  final List<Pet> _allPets = [
    Pet(id: 1, name: 'Waffles', breed: 'Corgi', age: 2, imageUrl: 'https://images.unsplash.com/photo-1558788353-f76d92427f16?ixlib=rb-4.0.3&q=85&fm=jpg&crop=entropy&cs=srgb&w=1200', description: 'Waffles is a playful and stubby-legged friend who loves belly rubs and short walks.'),
    Pet(id: 2, name: 'Shadow', breed: 'Maine Coon', age: 3, imageUrl: 'https://th.bing.com/th/id/R.1560d9911f88920814800cfecd98a58b?rik=pQCnbEZKiZU%2flw&riu=http%3a%2f%2feskipaper.com%2fimages%2fblack-cat-1.jpg&ehk=aeqem48w6QiVGGhrE5DH3gn9WsE%2bfPkT4YI2XalfMK4%3d&risl=&pid=ImgRaw&r=0', description: 'Shadow is a gentle giant with a magnificent fluffy coat. He loves to nap and watch birds from the window.'),
    Pet(id: 3, name: 'Thumper', breed: 'Dutch Rabbit', age: 1, imageUrl: 'https://bunnystyleguide.com/wp-content/uploads/2022/03/dutch-rabbit.jpg', description: 'Thumper is an energetic and curious rabbit. He loves hopping around and munching on fresh carrots.'),
    Pet(id: 4, name: 'Peanut', breed: 'Chihuahua', age: 4, imageUrl: 'https://images.unsplash.com/photo-1600804340584-c7db2eacf0bf?ixlib=rb-4.0.3&q=85&fm=jpg&crop=entropy&cs=srgb&w=1200', description: 'Peanut is a tiny dog with a huge personality. He is fiercely loyal and loves to be carried around.'),
    Pet(id: 5, name: 'Kiwi', breed: 'Parakeet', age: 1, imageUrl: 'https://tse4.mm.bing.net/th/id/OIP.WyZix6KRE5f2yZlK3t5jkAHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', description: 'Kiwi is a cheerful and chatty parakeet. He enjoys mimicking sounds and sitting on shoulders.'),
  ];

  // We use a Set for favorites for efficient add/remove/contains checks
  final Set<int> _favoritePetIds = {};

  // --- STATE MANAGEMENT FUNCTIONS ---

  void _toggleFavorite(int petId) {
    setState(() {
      if (_favoritePetIds.contains(petId)) {
        _favoritePetIds.remove(petId);
      } else {
        _favoritePetIds.add(petId);
      }
    });
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  // --- DERIVED LISTS (Computed from state) ---

  List<Pet> get _favoritePets {
    return _allPets.where((pet) => _favoritePetIds.contains(pet.id)).toList();
  }

  List<Pet> get _searchedPets {
    if (_searchQuery.isEmpty) {
      return []; // Don't show any results if search is empty
    }
    return _allPets
        .where((pet) =>
            pet.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            pet.breed.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // --- WIDGETS ---

  List<Widget> _buildScreens() {
    return [
      // 0: Home Screen
      HomeScreen(
        pets: _allPets,
        favoritePetIds: _favoritePetIds,
        onToggleFavorite: _toggleFavorite,
      ),
      // 1: Search Screen
      SearchScreen(
        searchResults: _searchedPets,
        favoritePetIds: _favoritePetIds,
        onToggleFavorite: _toggleFavorite,
        onSearchChanged: _updateSearchQuery,
      ),
      // 2: Favorites Screen
      FavoritesScreen(
        favoritePets: _favoritePets,
        favoritePetIds: _favoritePetIds,
        onToggleFavorite: _toggleFavorite,
      ),
      // 3: Profile Screen
      const ProfileScreen(),
    ];
  }

  // List of titles for the AppBar
  final List<String> _appBarTitles = [
    'Pet Adoption',
    'Search Pets',
    'Your Favorites',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    // Get the dynamically built screens
    final screens = _buildScreens();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitles[_selectedIndex], // Title changes with the tab
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NotificationsScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed, // Good for 4+ items
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

