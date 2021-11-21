import 'package:flutter/material.dart';
import 'package:recipes/recipe.dart';
import 'package:recipes/recipe_detail.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  // 1
  @override
  Widget build(BuildContext context) {
    // 2
    final ThemeData theme = ThemeData();
    // 3
    return MaterialApp(
      // 4
      title: 'Recipe Calculator',
      // 5
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.blue,
          secondary: Colors.brown,
          background: Colors.lightBlueAccent,
        ),
      ),
      // 6
      home: const MyHomePage(title: 'Recipe Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(title: Text(widget.title));

    var child = ListView.builder(
      itemCount: Recipe.samples.length,
      itemBuilder: (BuildContext context, int index) {
        return cardGuestureReact(Recipe.samples[index]);
      },
    );
    var body = SafeArea(child: child);
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  Widget cardGuestureReact(Recipe recipe) {
    var pageRoute = MaterialPageRoute(builder: (context) {
      return RecipeDetail(recipe: recipe);
    });
    var gestureDetector = GestureDetector(
      onTap: () {
        Navigator.push(context, pageRoute);
      },
      child: buildRecipeCard(recipe),
    );
    return gestureDetector;
  }

  Widget buildRecipeCard(Recipe recipe) {
    var cardChildTextStyle = const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      fontFamily: 'Palatino',
    );
    var cardChild = Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Image(image: AssetImage(recipe.imageUrl)),
          const SizedBox(height: 14.0),
          Text(
            recipe.label,
            style: cardChildTextStyle,
          ),
        ]));
    return Card(
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: cardChild);
  }
}
