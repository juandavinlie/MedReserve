import 'package:flutter/material.dart';
import 'package:medreserve/models/hospital.dart';
import 'package:medreserve/models/localhospital.dart';
import 'package:medreserve/screens/pages/accepted.dart';
import 'package:medreserve/screens/pages/applicants.dart';
import 'package:medreserve/services/auth.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final titles = ["Applicants", "Accepted Applicants"];

  final pages = [Applicants(), Accepted()];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final localhospital = Provider.of<LocalHospital>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Text("Hospital Name: " + localhospital.name),
                  Text("Capacity: " + localhospital.capacity.toString())
                ]
              )
            ),
            FlatButton.icon(
              onPressed: () {AuthService().signOut();}, 
              icon: Icon(Icons.exit_to_app), 
              label: Text("Sign Out")
            )
          ],
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Applicants")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            title: Text("Accepted")
          ),
        ],
        onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
      ),
    );
  }
}