import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Diet extends StatefulWidget {
  const Diet({Key? key}) : super(key: key);

  @override
  State<Diet> createState() => _DietState();
}

class _DietState extends State<Diet> {
  final List<Map<String, dynamic>> _dietRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadDiet();
  }

  Future<void> _loadDiet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dietJson = prefs.getStringList('Diet');
    if (dietJson != null) {
      setState(() {
        _dietRecipes.addAll(dietJson.map((json) => jsonDecode(json) as Map<String, dynamic>));
      });
    }
  }

  Future<void> _addDietRecipe(String name, List<String> components) async {
    Map<String, dynamic> newDietRecipe = {
      'name': name,
      'components': components,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dietRecipes.add(newDietRecipe);
      prefs.setStringList('Diet', _dietRecipes.map((recipe) => jsonEncode(recipe)).toList());
    });
  }

  Future<void> _deleteDietRecipe(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dietRecipes.removeAt(index);
      prefs.setStringList('Diet', _dietRecipes.map((recipe) => jsonEncode(recipe)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Diet Recipes'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final Map<String, dynamic>? newDiet = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (BuildContext context) {
                  String name = '';
                  List<String> components = [];

                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        title: const Text('Add new recipe'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              onChanged: (value) {
                                name = value;
                              },
                              decoration: const InputDecoration(hintText: 'Recipe Name'),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    String component = '';
                                    return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return AlertDialog(
                                          title: Text('Add Component'),
                                          content: TextField(
                                            onChanged: (value) {
                                              component = value;
                                            },
                                            decoration: InputDecoration(hintText: 'Component Name'),
                                          ),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text('Add'),
                                              onPressed: () {
                                                if (component.isNotEmpty) {
                                                  setState(() {
                                                    components.add(component);
                                                  });
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text('Add Component'),
                            ),
                            SizedBox(height: 10),
                            if (components.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Components:',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Column(
                                    children: components
                                        .map((component) => Text(component))
                                        .toList(),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: const Text('Save'),
                            onPressed: () {
                              if (name.isNotEmpty && components.isNotEmpty) {
                                Navigator.of(context).pop({
                                  'name': name,
                                  'components': components,
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please enter a recipe name and at least one component.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );

              if (newDiet != null) {
                _addDietRecipe(newDiet['name'], newDiet['components']);
              }
            },
            child: const Icon(Icons.add,color: Colors.black,),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _dietRecipes.length,
        itemBuilder: (BuildContext context, int index) {
          String name = _dietRecipes[index]['name'];
          List<String> components = List<String>.from(_dietRecipes[index]['components']);
          return ListTile(
            title: Text('$name',style: TextStyle(color: Colors.black)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: components
                  .map((component) => Text(component,style: TextStyle(color: Colors.black54)))
                  .toList(),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete,color: Colors.black),
              onPressed: () => _deleteDietRecipe(index),
            ),
          );
        },
      ),
    );
  }
}
