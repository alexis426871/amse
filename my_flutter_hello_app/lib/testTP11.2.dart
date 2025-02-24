import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child : MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 105, 179, 105),
        //scaffoldBackgroundColor: Colors.white
      ),
      home: const BottomNavigationBarExample(),
    )
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
          backgroundColor: Colors.green,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Image.asset(
                 '/home/alexis/amse/my_flutter_hello_app/lib/logoIMTree.png',
                  fit: BoxFit.contain,
                  height: 32,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0), child: Text('IMTree'))
            ],

          )
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
    var appState = context.watch<MyAppState>();
    Map<String, IconData> icon={};//il faut le nom de l'arbre en clé
    IconData iconFiltreFav=Icons.check_box_outline_blank;
    appState.favoris.forEach((key, value) {
    if(value==1)
    {
      icon[key]=Icons.favorite;
    }
    else
    {
      icon[key]=Icons.favorite_border;
    }
  });

  if(appState.filtreFav)
  {
    iconFiltreFav=Icons.check_box;
  }
  else{
    iconFiltreFav=Icons.check_box_outline_blank;
  }
    
    return Column(
      children: [
        Image.asset("/home/alexis/amse/my_flutter_hello_app/lib/arbreTest.jpeg",fit :BoxFit.contain),
        ElevatedButton.icon(
              onPressed: () {
                appState.toggleFiltreFav();
              },
              icon: Icon(iconFiltreFav), // Utilisation correcte de la valeur de l'icône
              label: const Text('Like'),
            ),
        Expanded(
          child: ListView(
            //shrinkWrap: true, // Pas de scroll sur le ListView si pas nécessaire
            //padding: EdgeInsets.zero,
            children: icon.entries.map((arbre) {//qui contient <"arbre" et "icone Like ou non>"
      if(appState.filtreFav==false ||appState.favoris[arbre.key]==1)
      {
      return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child:  Text(arbre.key,
                  style: TextStyle(fontSize: 30, color: Colors.white))),
            ElevatedButton.icon(
              onPressed: () {
                appState.toggleFavorite(arbre.key);
              },
              icon: Icon(arbre.value), // Utilisation correcte de la valeur de l'icône
              label: const Text('Like'),
            ),
          ],
        ),
      );
      }
      return Container();


    }).toList() // Convertir en liste


              // Ajoute d'autres containers ici...
            ,
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
          margin: const EdgeInsets.all(50),
        padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child : Image.asset("/home/alexis/amse/my_flutter_hello_app/lib/testQuiz1.jpg", fit : BoxFit.contain)//A MODIFIERRRRRRRR LEEEE CHEEEMINNNN POUR LE PROFFF
          )
        ),
        Container(
          margin: const EdgeInsets.all(50),
        padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child : Image.asset("/home/alexis/amse/my_flutter_hello_app/lib/caracteristiquesArbres1.png", fit : BoxFit.contain)
          )
        ),
        Container(
          margin: const EdgeInsets.all(50),
        padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child : Image.asset("/home/alexis/amse/my_flutter_hello_app/lib/vosFavoris1.jpg", fit : BoxFit.contain)
          )
        ),
      ],
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("L'objectif est de cette application est la découverte des différents arbres qui nous entourent.\n\n\nLes données rassemblés ici proviennent du centre...national des forêts.\n\n La mémorisation des différents arbres peut se faire de manière ludique grâce au quiz présent au sein de l'application. \n\nRéalisation : Alexis MANUEL ");
  }
}

class MyAppState extends ChangeNotifier {
  Map<String, int> favoris = {
    "Pommier": 0,
    "Chene": 0,
    "Hetre": 0,
  };

  bool filtreFav=false;



  void toggleFavorite(String arbre) {
    if (favoris[arbre]==0) {
      favoris[arbre]=1;
    } else {
      favoris[arbre]=0;
    }
    notifyListeners();
  }

  void toggleFiltreFav()
  {
    if(filtreFav)
    {
      filtreFav=false;
    }
    else{
      filtreFav=true;
    }
    notifyListeners();
  }


}