import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pet/HomeScreen.dart';
import 'package:pet/SchedulePage.dart';

class Screen2 extends StatelessWidget {

  final String petName;

  const Screen2({required this.petName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('${petName}          '),
        ),
        backgroundColor: Color.fromARGB(255, 235, 156, 78),
      ),
      body: Center(
        child: Container(
          height: 625,
          width: 700,
          child: const Image(
            image:
                AssetImage('images/GameBackground.jpeg'),
            fit: BoxFit.cover,
          )
        )
      ),
      bottomNavigationBar: GNav(
        backgroundColor: Color.fromARGB(255, 235, 156, 78),
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Color.fromARGB(255, 241, 186, 123),
        gap: 5,
        padding: EdgeInsets.all(20),
        tabs: [
          GButton(
            icon: Icons.chevron_left,
            text: 'Back',
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
          ),
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.map,
            text: 'Map',
          ),
          GButton(
            icon: Icons.alarm,
            text: 'Schedule',
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulePage(petName: petName),
                  ),
                );
              },
          ),
        ],
      ),
      backgroundColor: Colors.pink[100],
    );
  }
}
