import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const FiltersROute = '/filters';

  final Function saveFilters;
  final Map<String, bool> filters;

  FiltersScreen(this.filters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;
  bool _isLactoseFree = false;

  @override
  initState() {
    _isGlutenFree = widget.filters['Gluten'];
    _isLactoseFree = widget.filters['Lactose'];
    _isVegetarian = widget.filters['Vegetarian'];
    _isVegan = widget.filters['Vegan'];
    super.initState();
  }

  Widget _buildSwitch(String title, String description, bool currentValue,
      Function updateValue) {
    return SwitchListTile(
      value: currentValue,
      title: Text(title),
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yours Filters!'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilter = {
                  'Gluten': _isGlutenFree,
                  'Lactose': _isLactoseFree,
                  'Vegetarian': _isVegetarian,
                  'Vegan': _isVegan,
                };
                widget.saveFilters(selectedFilter);
              }),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitch(
                'Gliten-Free',
                'Only include Gluten free meal',
                _isGlutenFree,
                (newValue) {
                  setState(
                    () {
                      _isGlutenFree = newValue;
                    },
                  );
                },
              ),
              _buildSwitch(
                'Lactose-Free',
                'Only include Lactose free meal',
                _isLactoseFree,
                (newValue) {
                  setState(
                    () {
                      _isLactoseFree = newValue;
                    },
                  );
                },
              ),
              _buildSwitch(
                'Vegetarian',
                'Only Vegetarian meal',
                _isVegetarian,
                (newValue) {
                  setState(
                    () {
                      _isVegetarian = newValue;
                    },
                  );
                },
              ),
              _buildSwitch(
                'Vegan',
                'Only Vegan free meal',
                _isVegan,
                (newValue) {
                  setState(
                    () {
                      _isVegan = newValue;
                    },
                  );
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
