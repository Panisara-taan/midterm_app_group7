import 'package:flutter/material.dart';

class FifthPage extends StatefulWidget{
  @override
  State<FifthPage> createState() => _FirstPageState();
}
 
class _FirstPageState extends State<FifthPage> {
  final _formKey = GlobalKey<FormState>();
 
  String? _Food;
  int _Foodlength = 0;
 
  String? _Calories;
  int _Calorieslength = 0;
 
  List<String> _FoodList = ['Tom Yum Goong', 'Thai Fried Rice', 'Pad Thai', 'Thai Fried Chicken',
  'Pla Plao', 'Som Tam', 'Green Curry', 'Jok', 'Pad See Ew', 'Beef Noodle Soup'];
  String? _foodName;
 
  List<String> _CalorieList = ['873.7', '704', '300', '609', '380', '97', '306', '119', '363', '523'];
  String? _calories = "";
 
  bool _showPassword = false;
 
  String? _validateTextFormField(String fieldName, String? value, int length) {
    if (value!.isEmpty) {
      return 'Please enter your $fieldName.';
      }
      if (value.length < 2) {
      return '$fieldName length must longer than 2.';
      }
      if (fieldName == 'FoodList') {
      if (_FoodList.contains(value)) {
        return 'This meal is already been added.';
      }
    }
    else {
      return 'Enter your food calories';
    }
      return null;
  }
 
  void navigateToNextPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealListPage(
        foodName: _foodName!,
        calories: _calories!,
      ),
    ));
  }
 
 
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('First Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/meal.png',
                height: 80,
              ),
              Text(
                'Meal & Calories',
                style: TextStyle(
                  fontSize: 40
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: 'Food Names',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.person),
                    hintText: 'Enter your food name',
                    labelText: 'Food Lists',
                    suffixText: '$_Foodlength',
                  ),
                  validator: (value) => _validateTextFormField('Food name', value, 2),
                  onSaved: (newValue) => _Food = newValue,            
                  onChanged: (value) {
                    setState(() {
                      _Foodlength = value.characters.length;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: 'Calories',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.group),
                    hintText: 'Enter your food calories',
                    labelText: 'All Calories',
                    suffixText: '$_Calorieslength',
                  ),
                  validator: (value) => _validateTextFormField('Calories', value, 5),
                  onSaved: (newValue) => _Calories = newValue,
                  onChanged: (value) {
                    setState(() {
                      _Calorieslength = value.characters.length;
                    });
                  }
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      navigateToNextPage();
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 16.0),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
class MealListPage extends StatelessWidget {
  final String foodName;
  final String calories;
 
  MealListPage({
    required this.foodName,
    required this.calories,
  });
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: $foodName', style: TextStyle(fontSize: 18)),
                      Text('Forms: $calories', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}