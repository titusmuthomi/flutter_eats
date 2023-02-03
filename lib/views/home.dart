import 'package:flutter/material.dart';
import 'package:tito_eats/models/recipe.api.dart';
import 'package:tito_eats/models/recipe.dart';
import 'package:tito_eats/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //integrate api
  late List<Recipe> _recipes;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });

    //test print
    //print(_recipes);
    // gets instances
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text("Tito's Kitchen")
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            // try streambuilder or any other block approach
            // if loaded show
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      title: _recipes[index].name,
                      cookTime: _recipes[index].totalTime,
                      rating: _recipes[index]
                          .rating
                          .toString(), //convert double to string
                      thumbnailUrl: _recipes[index].images);
                },
              ));
  }
}
