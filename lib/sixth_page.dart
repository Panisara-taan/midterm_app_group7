import 'package:flutter/material.dart';
import 'package:pobpad/second_page.dart';
import 'package:provider/provider.dart';

class SixthPage extends StatefulWidget {
  @override
  State<SixthPage> createState() => _SixthPageState();
}

class _SixthPageState extends State<SixthPage> {
  final _formKey = GlobalKey<FormState>();
  final List<dynamic> mealList = [
    [
      'Tom Yum Goong',
      '873.7 Kcal',
      'https://hot-thai-kitchen.com/wp-content/uploads/2013/03/tom-yum-goong-blog.jpg'
    ],
    [
      'Thai Fried Rice',
      '704 Kcal',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Thaifriedrice.jpg/1376px-Thaifriedrice.jpg'
    ],
    [
      'Pad Thai',
      '300 Kcal',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Phat_Thai_kung_Chang_Khien_street_stall.jpg/1280px-Phat_Thai_kung_Chang_Khien_street_stall.jpg'
    ],
    [
      'Thai Fried Chicken',
      '609 Kcal',
      'https://hot-thai-kitchen.com/wp-content/uploads/2022/09/hat-yai-fried-chicken-blog.jpg'
    ],
    [
      'Pla Plao',
      '380 Kcal',
      'https://www.eatingthaifood.com/wp-content/uploads/2014/01/thai-grilled-fish-recipe-feature.jpg'
    ],
    [
      'Som Tam',
      '97 Kcal',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/2013_Tam_Lao.jpg/1280px-2013_Tam_Lao.jpg'
    ],
    [
      'Green Curry',
      '306 Kcal',
      'https://www.recipetineats.com/tachyon/2019/02/Thai-Green-Curry_5.jpg'
    ],
    [
      'Jok',
      '119 Kcal',
      'https://fearlesseating.net/wp-content/uploads/2018/01/for-book-thai-congee-joke-1024x683.jpg'
    ],
    [
      'Pad See Ew',
      '363 Kcal',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Pad_see_ew.jpg/1280px-Pad_see_ew.jpg'
    ],
    [
      'Beef Noodle Soup',
      '523 Kcal',
      'https://www.marionskitchen.com/wp-content/uploads/2022/09/Slow-cooker-Thai-Beef-Noodle-Soup-02.jpg'
    ],
  ];

  String _chooseMeal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Meal Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardListPage(
                        nameList: mealList,
                      ),
                    ),
                  );
                },
                child: Text('Select card : $_chooseMeal'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MealListPage(),
                  ),
                );
              }, child: Consumer<Meal>(
                builder: (context, meal, child) {
                  return Text('Select Meal: ${meal.calorieLevel}');
                },
              )),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Select ... : ')),
          ],
        ),
      ),
    );
  }
}

class CardListPage extends StatelessWidget {
  const CardListPage({
    super.key,
    required this.nameList,
  });

  final List<dynamic> nameList;

  @override
  Widget build(BuildContext context) {
    var mealList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Card List Page'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: mealList.length,
        itemBuilder: (context, index) {
          return NameCard(
            data: NameCardData(
              name: nameList[index][0],
              dob: nameList[index][1],
              imageUrl: nameList[index][2],
            ),
          );
        },
      ),
    );
  }
}

class MealListPage extends StatefulWidget {
  @override
  State<MealListPage> createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  int calorieLevel = 0;

  final List<String> _MealandCalorieList = [
    'Tom Yum Goong, 873.7 Kcal',
    'Thai Fried Rice, 704 Kcal',
    'Pad Thai, 300 Kcal',
    'Thai Fried Chicken, 609 Kcal',
    'Pla Plao, 380 Kcal',
    'Som Tam, 97 Kcal',
    'Green Curry, 306 Kcal',
    'Jok, 119.6 Kcal',
    'Pad See Ew, 363 Kcal',
    'Beef Noodle Soup, 523 Kcal'
  ];

  String? _MealandCalorieSuffix = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Meal List Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ChoiceCard(
                choiceData: ChoiceData(
              title: 'Meal & Calorie Level',
              choices: _MealandCalorieList,
              groupValue: calorieLevel,
              onChanged: (int newValue) {
                setState(() {
                  calorieLevel = newValue;
                });
              },
            )),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(
                  '${_MealandCalorieList[calorieLevel - 1]}',
                );
                context.read<Meal>().calorieLevel = calorieLevel - 1;
                Navigator.pop(context);
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}

class Meal extends ChangeNotifier {
  String? _calorieLevel;

  get calorieLevel => this._calorieLevel;
  set calorieLevel(value) {
    this._calorieLevel = value;
    notifyListeners();
  }
}

class NameCardData {
  const NameCardData({
    required this.name,
    required this.dob,
    required this.imageUrl,
  });

  final String name;
  final String dob;
  final String imageUrl;
}

class NameCard extends StatelessWidget {
  const NameCard({
    super.key,
    required this.data,
  });

  final NameCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100.0,
            child: Image.network(
              data.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${data.name}'),
              Text('DOB: ${data.dob}'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, data.name);
                },
                child: Text('Select'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MovieCardData {
  final String title;
  final String releaseDate;
  final String imageUrl;

  MovieCardData({
    required this.title,
    required this.releaseDate,
    required this.imageUrl,
  });
}

class MovieCard extends StatelessWidget {
  final MovieCardData data;

  const MovieCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            child: Image.network(
              data.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: ${data.title}'),
                Text('Release Date: ${data.releaseDate}'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, data.title);
                  },
                  child: Text('Select'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
