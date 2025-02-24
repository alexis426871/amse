import 'dart:math';
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
    Quiz(),
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
                 'assets/images/logoIMTree.png',
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
        type: BottomNavigationBarType.fixed,
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
            icon: Icon(Icons.help_outline),
            label: 'Quiz',
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
        Image.asset("assets/images/arbreTest.jpeg",fit :BoxFit.contain),
        Container(
          margin: const EdgeInsets.all(10),
          color : Colors.green,
          child: Row(
            children: [ Text("Filtre : ", style : TextStyle(fontSize : 20, color : Colors.white)),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: ElevatedButton.icon(
                      onPressed: () {
                        appState.toggleFiltreFav();
                      },
                      icon: Icon(iconFiltreFav), // Utilisation correcte de la valeur de l'icône
                      label: const Text('Favoris'),
                    ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            //shrinkWrap: true, // Pas de scroll sur le ListView si pas nécessaire
            //padding: EdgeInsets.zero,
            children: icon.entries.map((arbre) {//qui contient <"arbre" et "icone Like ou non>"
      if(appState.filtreFav==false ||appState.favoris[arbre.key]==1)
      {
      return 
      InkWell(
      onTap: () {
        Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArbreDetailsPage(arbre : arbre.key), // Envoie le nom de l'arbre à la nouvelle page
      ),
    );
      },
      child : Container(
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
              label: const Text(''),
            ),
          ],
        ),
      )
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
            child : Image.asset("assets/images/testQuiz1.jpg", fit : BoxFit.contain)//A MODIFIERRRRRRRR LEEEE CHEEEMINNNN POUR LE PROFFF
          )
        ),
        Container(
          margin: const EdgeInsets.all(50),
        padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child : Image.asset("assets/images/caracteristiquesArbres1.png", fit : BoxFit.contain)
          )
        ),
        Container(
          margin: const EdgeInsets.all(50),
        padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child : Image.asset("assets/images/vosFavoris1.jpg", fit : BoxFit.contain)
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
    return  Container(
               margin: const EdgeInsets.all(50),
                padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                            color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
        ),
              child: Text("L'objectif de l'application IMTree est la découverte des différents arbres qui nous entourent.\n\n\nLa mémorisation des différents arbres peut se faire de manière ludique grâce au quiz présent au sein de l'application. \n\nRéalisation : Alexis MANUEL ",style: TextStyle(fontSize: 15, color: Colors.white))

      );
  }
}

class MyAppState extends ChangeNotifier {
  Map<String, int> favoris = {/*
    "Pommier": 0,
    "Chene": 0,
    "Hetre": 0,*/
    "Chêne sessile" : 0,
    "Chêne pédonculé" : 0,
    "Charme" : 0,
    "Peuplier tremble" : 0,
    "Bouleau" : 0,
    "Orme" : 0,
    "Tilleul" : 0,
    "Aulne" : 0,
    "Merisier" : 0,
    "Alisier blanc" : 0,
    "Châtaignier" : 0,
    "Noisetier" : 0,
    "Alisier torminal" : 0,
    "Saule marsault" : 0,
    "Hêtre" : 0,
    "Érable plane" : 0,
    "Érable champêtre" : 0,
    "Érable sycomore" : 0
  };
  
  bool filtreFav=false;
  bool aRepondu=false;
  bool motEstAffiche=false;
  late String motADeviner;
  var random = Random();
  
  MyAppState() {
    
    motADeviner = _getRandomMot2();
  }
  void _getRandomMot() {
    motADeviner= favoris.keys.elementAt(random.nextInt(favoris.length));
    motEstAffiche=false;
    notifyListeners();
    
  }
  String _getRandomMot2() {
    return favoris.keys.elementAt(random.nextInt(favoris.length));
  }

  void toggleARepondu()
  {
    if(aRepondu)
    {
      aRepondu=false;
    }
    else{
      aRepondu=true;
    }
  }
  void toggleMotEstAffiche() {
    if (motEstAffiche) {
      motEstAffiche=false;
    } else {
      motEstAffiche=true;
    }
    notifyListeners();
  }


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

class ArbreDetailsPage extends StatelessWidget
{
  String arbre;
  ArbreDetailsPage({super.key, required this.arbre});
  Map<String,String> descriptionFeuilles={
    "Chêne sessile" : "Feuille simple, alterne, bord lobé, pétiole long, gland attaché au rameau",
"Chêne pédonculé" : "Feuille simple, alterne, bord lobé, pétiole court, gland au bout d’un pédoncule",
"Charme" : "Feuille simple, alterne, bord denté, feuille gaufrée, dents fines",
"Peuplier tremble" : "Feuille simple, alterne, bord denté, feuille en triangle ou arrondie, queue plate",
"Bouleau" : "Feuille simple, alterne, bord denté, feuille en triangle ou losange, queue ronde",
"Orme" : "Feuille simple, alterne, bord denté, feuille à base décalée, gaufrée, 1 à 3 pointes au sommet",
"Tilleul" : "Feuille simple, alterne, bord denté, feuille en cœur avec pointe au sommet",
"Aulne" : "Feuille simple, alterne, bord denté, feuille ronde aplatie au sommet, bourgeon violet",
"Merisier" : "Feuille simple, alterne, bord denté, feuille allongée, 2 glandes rouges à la base",
"Alisier blanc" : "Feuille simple, alterne, bord denté, feuille brillante dessus, blanche dessous",
"Châtaignier" : "Feuille simple, alterne, bord denté, feuille longue, dents fortes",
"Noisetier" : "Feuille simple, alterne, bord denté, feuille en cœur, grande, râpeuse",
"Alisier torminal" : "Feuille simple, alterne, bord denté, feuille à lobes inégaux",
"Saule marsault" : "Feuille simple, alterne, bord lisse, feuille légèrement asymétrique",
"Hêtre" : "Feuille simple, alterne, bord lisse, feuille ondulée, bord avec de petits poils blancs, bourgeons pointus",
"Érable plane" : "Feuille simple, opposée, palmé à 5 lobes, grandes feuilles, lobes pointus",
"Érable champêtre" : "Feuille simple, opposée, palmé à 5 lobes, petites feuilles, lobes arrondis",
"Érable sycomore" : "Feuille simple, opposée, palmé à 5 lobes, grandes feuilles, lobes en ogives dentées"
  };
  Map<String,String> descriptionArbres={
    "Chêne sessile" : "Grand arbre robuste des forêts tempérées, il produit des glands fixés directement sur les rameaux et possède un bois très apprécié en menuiserie et tonnellerie.",
"Chêne pédonculé" : "Espèce emblématique des forêts européennes, il se distingue par ses glands portés par un long pédoncule et son feuillage dense qui offre un ombrage généreux.",
"Charme" : "Arbre élégant aux feuilles finement dentées et gaufrées, il est souvent utilisé en haies ou en alignements grâce à son feuillage dense et son bois dur.",
"Peuplier tremble" : "Reconnaissable à ses feuilles qui frémissent au moindre souffle de vent, il pousse rapidement et colonise facilement les terrains humides.",
"Bouleau" : "Arbre à l'écorce blanche caractéristique, il est apprécié pour son élégance et sa capacité à pousser sur des sols pauvres, souvent le premier à coloniser les clairières.",
"Orme" : "Autrefois répandu en Europe, il a souffert de la graphiose, une maladie qui a décimé de nombreuses populations ; il se reconnaît à ses feuilles dissymétriques et rugueuses.",
"Tilleul" : "Arbre majestueux souvent planté dans les parcs et les allées, il est apprécié pour ses fleurs odorantes utilisées en infusion et son feuillage en forme de cœur.",
"Aulne" : "Arbre des milieux humides, il joue un rôle essentiel en stabilisant les berges et en enrichissant les sols grâce à ses racines associées à des bactéries fixatrices d’azote.",
"Merisier" : "Cousin sauvage du cerisier, il produit de petites cerises appréciées des oiseaux et possède un bois rougeâtre prisé en ébénisterie.",
"Alisier blanc" : "Arbre discret des haies et des forêts claires, il offre de petits fruits comestibles et possède un bois dense utilisé en tournerie.",
"Châtaignier" : "Essence emblématique des régions tempérées, il est connu pour ses fruits comestibles et son bois durable utilisé en charpente et en tonnellerie.",
"Noisetier" : "Arbuste ou petit arbre produisant des noisettes, il est souvent cultivé dans les haies et apprécié pour ses rameaux souples utilisés en vannerie.",
"Alisier torminal" : "Espèce rare aux feuilles profondément lobées, il produit des fruits comestibles appréciés autrefois en cuisine et en médecine traditionnelle.",
"Saule marsault" : "Arbre pionnier des milieux humides, il est un refuge pour de nombreux insectes et pollinisateurs, et ses bourgeons précoces nourrissent les abeilles au printemps.",
"Hêtre" : "Arbre majestueux des forêts européennes, il forme souvent des forêts denses au sous-bois sombre et possède un bois très utilisé en ameublement.",
"Érable plane" : "Grand arbre aux feuilles palmées, il est souvent planté en alignement pour son ombre généreuse et son bois apprécié en ébénisterie.",
"Érable champêtre" : "Petit érable rustique, il est commun dans les haies bocagères et se distingue par ses feuilles plus petites aux lobes arrondis.",
"Érable sycomore" : "Arbre imposant souvent planté en ville et en bord de route, il possède un feuillage dense et résistant à la pollution."
  };
  Map<String,String> lienImageArbre={
    "Chêne sessile" : "assets/images/Images/chenesessile3.jpg",
"Chêne pédonculé" : "assets/images/Images/chenePedoncule.jpg",
"Charme" : "assets/images/Images/charme.jpg",
"Peuplier tremble" : "assets/images/Images/peuplierTremble.jpg",
"Bouleau" : "assets/images/Images/Bouleau.jpg",
"Orme" : "assets/images/Images/Orme.jpg",
"Tilleul" : "assets/images/Images/Tilleul.jpg",
"Aulne" : "assets/images/Images/aulne.jpg",
"Merisier" : "assets/images/Images/Merisier.jpg",
"Alisier blanc" : "assets/images/Images/AlisierBlanc.jpg",
"Châtaignier" : "assets/images/Images/Chataignier.jpg",
"Noisetier" : "assets/images/Images/Noisetier.jpg",
"Alisier torminal" : "assets/images/Images/AlisierTorminal.jpg",
"Saule marsault" : "assets/images/Images/SauleMarsault.jpg",
"Hêtre" : "assets/images/Images/hetre.jpg",
"Érable plane" : "assets/images/Images/ErablePlat.jpg",
"Érable champêtre" : "assets/images/Images/ErableChampetre.jpg",
"Érable sycomore" : "assets/images/Images/ErableSycomore.jpg"
  
  };
  Map<String, String> lienImageFeuille={
    "Chêne sessile" : "assets/images/Images/Feuilles/CheneSessile.png",
"Chêne pédonculé" : "assets/images/Images/Feuilles/ChenePedoncule.png",
"Charme" : "assets/images/Images/Feuilles/CharmeFeuille.png",
"Peuplier tremble" : "assets/images/Images/Feuilles/PeuplierTremble.png",
"Bouleau" : "assets/images/Images/Feuilles/Bouleau.png",
"Orme" : "assets/images/Images/Feuilles/Orme.png",
"Tilleul" : "assets/images/Images/Feuilles/Tilleul.png",
"Aulne" : "assets/images/Images/Feuilles/Aulne.png",
"Merisier" : "assets/images/Images/Feuilles/Merisier.png",
"Alisier blanc" : "assets/images/Images/Feuilles/AliserBlanc.png",
"Châtaignier" : "assets/images/Images/Feuilles/Chataignier.png",
"Noisetier" : "assets/images/Images/Feuilles/Noisetier.png",
"Alisier torminal" : "assets/images/Images/Feuilles/AlisierTorminal.png",
"Saule marsault" : "assets/images/Images/Feuilles/SauleMarsault.png",
"Hêtre" : "assets/images/Images/Feuilles/Hetre.png",
"Érable plane" : "assets/images/Images/Feuilles/ErablePlane.png",
"Érable champêtre" : "assets/images/Images/Feuilles/ErableChampetre.png",
"Érable sycomore" : "assets/images/Images/Feuilles/ErableSycomore.png"
  };
  @override
Widget build(BuildContext context) {
  return Container(
    color : Color.fromARGB(255, 105, 179, 105),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Cette ligne permet de revenir à la page précédente
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              label: Text(""),
            ),
          ],
        ),
        Text(arbre,style: TextStyle(fontSize: 45, color: Colors.white)),
        Expanded(  // Permet au ListView d'occuper l'espace restant
          child: ListView(
            children: [
              Container(
                constraints: BoxConstraints(
                maxWidth: 600,  // Largeur maximale de 300 pixels
                maxHeight: 600, // Hauteur maximale de 200 pixels
              ),
                margin: const EdgeInsets.only(right: 50, bottom : 10, left : 50),
                padding: const EdgeInsets.all(10),
                child: Image.asset(lienImageArbre[arbre] ?? "erreur", fit: BoxFit.contain)),
              Container(
                constraints: BoxConstraints(
                maxWidth: 600,  // Largeur maximale de 300 pixels
                maxHeight: 600, // Hauteur maximale de 200 pixels
              ),
                margin: const EdgeInsets.only(right: 50, bottom : 10, left : 50),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                color: const Color.fromARGB(255, 89, 142, 185),
                borderRadius: BorderRadius.circular(20),
              ),
                child: Text((descriptionArbres[arbre] ?? "Description feuille non disponible"),
                style : TextStyle(fontSize : 20, color : Colors.white, decoration: TextDecoration.none)),
              ),
              Container(
                constraints: BoxConstraints(
                maxWidth: 600,  // Largeur maximale de 300 pixels
                maxHeight: 600, // Hauteur maximale de 200 pixels
              ),
                margin: const EdgeInsets.only(right: 50, bottom : 10, left : 50),
                padding: const EdgeInsets.all(10),
                child: Image.asset(lienImageFeuille[arbre] ?? "erreur", fit: BoxFit.contain)),
              Container(
                constraints: BoxConstraints(
                maxWidth: 600,  // Largeur maximale de 300 pixels
                maxHeight: 600, // Hauteur maximale de 200 pixels
              ),
                margin: const EdgeInsets.only(right: 50, bottom : 30, left : 50),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                color: const Color.fromARGB(255, 89, 142, 185),
                borderRadius: BorderRadius.circular(20),
              ),
                child: Text((descriptionFeuilles[arbre] ?? "Description feuille non disponible"),
                style : TextStyle(fontSize : 20, color : Colors.white, decoration: TextDecoration.none)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

}

class Quiz extends StatefulWidget{
    Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
   Map<String, String> lienImageFeuille={
    "Chêne sessile" : "assets/images/Images/Feuilles/CheneSessile.png",
"Chêne pédonculé" : "assets/images/Images/Feuilles/ChenePedoncule.png",
"Charme" : "assets/images/Images/Feuilles/CharmeFeuille.png",
"Peuplier tremble" : "assets/images/Images/Feuilles/PeuplierTremble.png",
"Bouleau" : "assets/images/Images/Feuilles/Bouleau.png",
"Orme" : "assets/images/Images/Feuilles/Orme.png",
"Tilleul" : "assets/images/Images/Feuilles/Tilleul.png",
"Aulne" : "assets/images/Images/Feuilles/Aulne.png",
"Merisier" : "assets/images/Images/Feuilles/Merisier.png",
"Alisier blanc" : "assets/images/Images/Feuilles/AliserBlanc.png",
"Châtaignier" : "assets/images/Images/Feuilles/Chataignier.png",
"Noisetier" : "assets/images/Images/Feuilles/Noisetier.png",
"Alisier torminal" : "assets/images/Images/Feuilles/AlisierTorminal.png",
"Saule marsault" : "assets/images/Images/Feuilles/SauleMarsault.png",
"Hêtre" : "assets/images/Images/Feuilles/Hetre.png",
"Érable plane" : "assets/images/Images/Feuilles/ErablePlane.png",
"Érable champêtre" : "assets/images/Images/Feuilles/ErableChampetre.png",
"Érable sycomore" : "assets/images/Images/Feuilles/ErableSycomore.png"
  };

Map<String,String> descriptionFeuilles={
    "Chêne sessile" : "Feuille simple, alterne, bord lobé, pétiole long, gland attaché au rameau",
"Chêne pédonculé" : "Feuille simple, alterne, bord lobé, pétiole court, gland au bout d’un pédoncule",
"Charme" : "Feuille simple, alterne, bord denté, feuille gaufrée, dents fines",
"Peuplier tremble" : "Feuille simple, alterne, bord denté, feuille en triangle ou arrondie, queue plate",
"Bouleau" : "Feuille simple, alterne, bord denté, feuille en triangle ou losange, queue ronde",
"Orme" : "Feuille simple, alterne, bord denté, feuille à base décalée, gaufrée, 1 à 3 pointes au sommet",
"Tilleul" : "Feuille simple, alterne, bord denté, feuille en cœur avec pointe au sommet",
"Aulne" : "Feuille simple, alterne, bord denté, feuille ronde aplatie au sommet, bourgeon violet",
"Merisier" : "Feuille simple, alterne, bord denté, feuille allongée, 2 glandes rouges à la base",
"Alisier blanc" : "Feuille simple, alterne, bord denté, feuille brillante dessus, blanche dessous",
"Châtaignier" : "Feuille simple, alterne, bord denté, feuille longue, dents fortes",
"Noisetier" : "Feuille simple, alterne, bord denté, feuille en cœur, grande, râpeuse",
"Alisier torminal" : "Feuille simple, alterne, bord denté, feuille à lobes inégaux",
"Saule marsault" : "Feuille simple, alterne, bord lisse, feuille légèrement asymétrique",
"Hêtre" : "Feuille simple, alterne, bord lisse, feuille ondulée, bord avec de petits poils blancs, bourgeons pointus",
"Érable plane" : "Feuille simple, opposée, palmé à 5 lobes, grandes feuilles, lobes pointus",
"Érable champêtre" : "Feuille simple, opposée, palmé à 5 lobes, petites feuilles, lobes arrondis",
"Érable sycomore" : "Feuille simple, opposée, palmé à 5 lobes, grandes feuilles, lobes en ogives dentées" 
  };

    var random = Random();

  // Récupérer une clé aléatoire
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
          child : Image.asset(lienImageFeuille[appState.motADeviner] ?? "Érable sycomore", fit : BoxFit.contain),
        ),
        Container(
          margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
          child:Text("Caractéristiques : ${descriptionFeuilles[appState.motADeviner]}\n\n\n A quel arbre correspond cette feuille ? ",style: TextStyle(fontSize: 15, color: Colors.white))

        ),
        Visibility(
           visible: appState.motEstAffiche, // Si false, cache l'élément
            child: Text("${appState.motADeviner}",style: TextStyle(fontSize: 15, color: Colors.white)
            ),),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                            onPressed: () {
                              appState._getRandomMot();
                            },
                            // Utilisation correcte de la valeur de l'icône
                            label: const Text('Next'),
                          ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                            onPressed: () {
                              appState.toggleMotEstAffiche();
                            },
                            // Utilisation correcte de la valeur de l'icône
                            label: const Text('Réponse'),
                          ),
            ),
          
          ],
        )

      ],
    );
  }
}