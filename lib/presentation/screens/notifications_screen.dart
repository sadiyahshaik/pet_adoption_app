import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: GoogleFonts.poppins()),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Your notifications will appear here',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
