import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Favorite Word App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  List<Widget> _getPages() {
    return [
      HomePage(),
      DiscoveryPage(),
      BookmarkPage(),
      TopPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var pages = _getPages();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 222, 252), 
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar( 
        backgroundColor: Color.fromARGB(255, 217, 162, 216),
        indicatorColor: Colors.white, 
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index; 
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.location_on_outlined),
            label: 'Discovery',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            label: 'Bookmark',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            label: 'Top Foodie',
          ),
          NavigationDestination(
            icon: Icon(Icons.attribution),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.4; 

    return SingleChildScrollView( 
      child: SizedBox(
        height: MediaQuery.of(context).size.height*1.2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Surabaya, ID',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Align(
                alignment: Alignment.center,
                child: Card(
                  child: Container(
                    width: 480,
                    height: 250,
                    child: Image.asset(
                      'images/burger.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Popular',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PopularPage()),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox( 
              height: 218, 
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCard('images/kebab.png', cardWidth),
                  _buildCard('images/tortila.png', cardWidth),
                  _buildCard('images/rendang.png', cardWidth),
                  _buildCard('images/pancake.png', cardWidth),
                  _buildCard('images/egg.png', cardWidth),
                  _buildCard('images/sate.png', cardWidth),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Price',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BestPricePage()),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 218,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCard('images/sate.png', cardWidth),
                  _buildCard('images/tortila.png', cardWidth),
                  _buildCard('images/kebab.png', cardWidth),
                  _buildCard('images/pancake.png', cardWidth),
                  _buildCard('images/egg.png', cardWidth),
                  _buildCard('images/rendang.png', cardWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String imagePath, double cardWidth) {
    return Card(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 190,
              height: 210,
            ),
          ],
        ),
      ),
    );
  }
}

class PopularPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 222, 252),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 217, 162, 216),
        title: Text('Most Popular'),
      ),
      body: ListView( 
        children: [
          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/kebab.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 15,),

          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/tortila.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 15,),

          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/rendang.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 15,),

          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/pancake.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 15,),

          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/egg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 15,),

          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/sate.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BestPricePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 222, 252),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 217, 162, 216),
        title: Text('Best Price'),
      ),
      body: ListView( 
        children: [
          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/sate.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 15,),

          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/tortila.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 15,),

          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/kebab.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 15,),

          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/pancake.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 15,),

          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/egg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 15,),

          Card(
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/rendang.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiscoveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Align(
              alignment: Alignment.center,
              child: Card(
                child: Container(
                  width: 480,
                  height: double.infinity,
                  child: Image.asset(
                    'images/map.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8),
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.food_bank_outlined),
                  title: Text("Little Turkish"),
                  subtitle: Text("Turkish Cuisine"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.food_bank_outlined),
                  title: Text("Botanika"),
                  subtitle: Text("Indonesian Cuisine"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.food_bank_outlined),
                  title: Text("Braud"),
                  subtitle: Text("Western Cuisine"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.food_bank_outlined),
                  title: Text("Bombaburger"),
                  subtitle: Text("Western Cuisine"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.food_bank_outlined),
                  title: Text("Mexicana"),
                  subtitle: Text("Mexican Cuisine"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.food_bank_outlined),
                  title: Text("Dessertian"),
                  subtitle: Text("Cake & Dessert"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.food_bank_outlined),
                  title: Text("Sate Kenangan"),
                  subtitle: Text("Indonesian Cuisine"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.food_bank_outlined),
                  title: Text("Pinerro"),
                  subtitle: Text("France Cuisine"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BookmarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8), 
            color: Color.fromARGB(255, 217, 162, 216), 
            child: Text(
              'My Favorite',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, 
              crossAxisSpacing: 8, 
              mainAxisSpacing: 15,
              children: [
                BookmarkCard(imageUrl: 'images/kebab.png'),
                BookmarkCard(imageUrl: 'images/rendang.png'),
                BookmarkCard(imageUrl: 'images/egg.png'),
                BookmarkCard(imageUrl: 'images/pancake.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookmarkCard extends StatefulWidget {
  final String imageUrl;

  BookmarkCard({required this.imageUrl});

  @override
  _BookmarkCardState createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard> {
  bool isBookmarked = false; 

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, 
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.imageUrl), 
                fit: BoxFit.cover, 
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border, 
                color: Colors.white,
                size: 24,
              ),
              onPressed: toggleBookmark, 
            ),
          ),
        ],
      ),
    );
  }
}

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8), 
            color: Color.fromARGB(255, 217, 162, 216), 
            child: Text(
              'Rank List',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
          flex: 2,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8),
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.looks_one_outlined),
                  title: Text("Braud"),
                  subtitle: Text("Western Cuisine"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.looks_two_outlined),
                  title: Text("Dessertian"),
                  subtitle: Text("Cake & Dessert"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.looks_3_outlined),
                  title: Text("Botanika"),
                  subtitle: Text("Indonesian Cuisine"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.looks_4_outlined),
                  title: Text("Bombaburger"),
                  subtitle: Text("Western Cuisine"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.looks_5_outlined),
                  title: Text("Little Turkish"),
                  subtitle: Text("Turkish Cuisine"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.looks_6_outlined),
                  title: Text("Mexicana"),
                  subtitle: Text("Mexican Cuisine"),
                ),
              ),
            ],
          ),
        ),
      ],
      )
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('images/Profile.jpg'), 
            ),

            SizedBox(height: 16),

          
            Text(
              'Otniel Wilson Setiabudi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            Text(
              'c14210293@john.petra.ac.id',
              style: TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),

            SizedBox(height: 9),

            Text(
              '"Food is not just sustenance; it is a journey where each dish is a story, each flavor a memory, and each meal a moment to savor."',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center, 
            ),

            SizedBox(height: 25),

            Image.asset(
              'images/logo.png', 
              height: 125,
            ),
          ],
        ),
      ),
    );
  }
}