import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false; // State for the dark mode switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Lighter background
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            FadeInUp(
              delay: const Duration(milliseconds: 100),
              child: Card(
                elevation: 3,
                shadowColor: Colors.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  leading: const Icon(Icons.dark_mode_outlined, color: Colors.deepPurple),
                  title: Text(
                    'Dark Mode',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Switch(
                    value: _isDarkMode,
                    onChanged: (val) {
                      setState(() {
                        _isDarkMode = val;
                        // You would add your theme-switching logic here
                      });
                    },
                    activeColor: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: _buildSettingOption(
                context: context,
                icon: Icons.language_outlined,
                title: 'Language',
                onTap: () {},
              ),
            ),
            const SizedBox(height: 15),
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: _buildSettingOption(
                context: context,
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {},
              ),
            ),
             const SizedBox(height: 15),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: _buildSettingOption(
                context: context,
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for a styled setting menu item (from ProfileScreen)
  Widget _buildSettingOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.deepPurple,
  }) {
    return Card(
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }
}

