import 'dart:convert';
import 'package:tito_eats/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https(
        'yummly2.p.rapidapi.com', '/feeds/list', {"q": "chicken soup"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "b9dcc6a15emshb64b555d4868721p129f71jsn17f883e74772 ",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"

      //use own key here
    });

    //create map data that gets response as data

    Map data = jsonDecode(response.body);
    List _temp = [];

//loop through data feed
    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}


// get request quey and headers from api
// const unirest = require("unirest");

// const req = unirest("GET", "https://yummly2.p.rapidapi.com/feeds/auto-complete");

// req.query({
// 	"q": "chicken soup"
// });

// req.headers({
// 	"X-RapidAPI-Key": "b9dcc6a15emshb64b555d4868721p129f71jsn17f883e74772",
// 	"X-RapidAPI-Host": "yummly2.p.rapidapi.com",
// 	"useQueryString": true
// });

// req.end(function (res) {
// 	if (res.error) throw new Error(res.error);

// 	console.log(res.body);
// });
