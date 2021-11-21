import 'package:flutter/material.dart';
import 'package:recipes/recipe.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetail({
    Key? key,
    required this.recipe,
  }) : super(key: key);
  @override
  _RecipeDetailState createState() {
    return _RecipeDetailState();
  }
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _sliderVal = 1;
  @override
  Widget build(BuildContext context) {
    var slider = Slider(
      min: 1,
      max: 10,
      divisions: 10,
      label: '${_sliderVal * widget.recipe.servings} servings',
      value: _sliderVal.toDouble(),
      onChanged: (newVal) {
        setState(() {
          _sliderVal = newVal.round();
        });
      },
      activeColor: Colors.green,
      inactiveColor: Colors.black,
    );
    var imagesizedBoxChild = SizedBox(
      height: 300,
      width: double.infinity,
      child: Image(
        image: AssetImage(widget.recipe.imageUrl),
      ),
    );
    var bodyChild = Column(
      children: [
        imagesizedBoxChild,
        const SizedBox(
          height: 4,
        ),
        Text(
          widget.recipe.label,
          style: const TextStyle(fontSize: 18),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(7.0),
              itemCount: widget.recipe.ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                final ingredient = widget.recipe.ingredients[index];
                return Text(
                    "${ingredient.quantity * _sliderVal} ${ingredient.measure} ${ingredient.name}");
              }),
        ),
        slider,
      ],
    );
    var body = SafeArea(child: bodyChild);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
      ),
      body: body,
    );
  }
}
