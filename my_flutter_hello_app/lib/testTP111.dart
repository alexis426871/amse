import 'package:flutter/material.dart';

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //scaffoldBackgroundColor: const Color.fromARGB(255, 105, 179, 105),
        scaffoldBackgroundColor: Colors.white
      ),
      home: const BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Media(),
    About(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Media',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Media extends StatelessWidget {
  const Media({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("/home/alexis/amse/my_flutter_hello_app/lib/arbreTest.jpeg"),
        Expanded(
          child: ListView(
            //shrinkWrap: true, // Pas de scroll sur le ListView si pas nécessaire
            //padding: EdgeInsets.zero,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Pommier", style: TextStyle(fontSize: 20)),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.green[100],
                child: const Text("Peuplier", style: TextStyle(fontSize: 20)),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              ),Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[100],
                child: const Text("Saule", style: TextStyle(fontSize: 20)),
              )
              // Ajoute d'autres containers ici...
            ],
          ),
        ),
      ],
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        const Text("Ce que propose IMTree :"),
        Container(
          margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green, // Couleur de fond
        borderRadius: BorderRadius.circular(20), // Rayon des coins arrondis
      ),
        child : Text("Un super quiz pour apprendre à reconnaître les arbres (grâce à leurs feuilles) ",
                      style: TextStyle(
                      fontSize: 48, // Taille du texte
        )
        )
        ),
        Container(
          margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green, // Couleur de fond
        borderRadius: BorderRadius.circular(20), // Rayon des coins arrondis
      ),
        child : Text("Caractéristiques des arbres")
        ),
        Container(
          margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green, // Couleur de fond
        borderRadius: BorderRadius.circular(20), // Rayon des coins arrondis
      ),
        child : Text("Possibilité de trier les arbres par types et par favoris !")
        )
      ],
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Voici mon About");
  }
}
