import 'package:flutter/material.dart';

import '../model/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class TabsBottomScreen extends StatefulWidget {
  final List<Meal> _favoritesMeal;

  TabsBottomScreen(this._favoritesMeal);

  @override
  _TabsBottomScreenState createState() => _TabsBottomScreenState();
}

class _TabsBottomScreenState extends State<TabsBottomScreen> {
  List<Map<String, Object>> page;

  int _selectedIndex = 0;

  @override
  initState() {
    page = [
    {'page': CategoriesScreen(), 'title': 'Categories'},
    {'page': FavoritesScreen(widget._favoritesMeal), 'title': 'My Favorites'}
  ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(page[_selectedIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: page[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.category),
            title: const Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.favorite),
            title: const Text('Favorite'),
          ),
        ],
      ),
    );
  }
}
