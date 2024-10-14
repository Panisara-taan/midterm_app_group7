import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  String? Name = '';
  int? Age = 0;
  String? DrugAllergy = '';
  String getMenuText(int index) {
    if (index == 0) {
      return 'Profile';
    }
    if (index == 1) {
      return 'Medication';
    }
    if (index == 2) {
      return 'Activity';
    }
    if (index == 3) {
      return 'Activity History';
    }
    if (index == 4) {
      return 'Meal & Calories';
    }
    if (index == 5) {
      return 'Meal Page';
    }

    return '';
  }

  String getMenuImage(int index) {
    if (index == 0) {
      return 'assets/images/profile.png';
    }
    if (index == 1) {
      return 'assets/images/medication.png';
    }
    if (index == 2) {
      return 'assets/images/activity.png';
    }
    if (index == 3) {
      return 'assets/images/history.png';
    }
    if (index == 4) {
      return 'assets/images/meal.png';
    }
    if (index == 5) {
      return 'assets/images/cal.png';
    }

    return '';
  }

  void navigateToPage(BuildContext context, int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else {
      Navigator.pushNamed(context, '/${index + 1}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(''),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(8.0),
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                } else {
                  Navigator.pushNamed(context, '/${index + 1}');
                }
              },
              child: Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      getMenuImage(index),
                      height: 70,
                    ),
                    Text(
                      getMenuText(index),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String age = '';
  String drugAllergy = '';

  List<String> NameList = ['Panisara', 'taan'];

  String? validateProfileTextFormField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value.';
    }
    if (NameList.contains(value)) {
      return 'This Name already been used';
    }
    return null;
  }

  void navigateToInformationPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InformationPage(
          name: name,
          age: age,
          drugAllergy: drugAllergy,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/profile.png',
                  height: 80,
                ),
                Text(
                  'Profile Information',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      labelText: 'Name',
                      hintText: 'Enter your name',
                    ),
                    validator: validateProfileTextFormField,
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      labelText: 'Age',
                      hintText: 'Enter your Age',
                    ),
                    validator: validateProfileTextFormField,
                    onChanged: (value) {
                      setState(() {
                        age = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      labelText: 'Drug Allergy',
                      hintText: 'Add Drug Allergy',
                    ),
                    validator: validateProfileTextFormField,
                    onChanged: (value) {
                      setState(() {
                        drugAllergy = value;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      navigateToInformationPage();
                    }
                  },
                  child: Text(
                    'Save',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InformationPage extends StatelessWidget {
  final String name;
  final String age;
  final String drugAllergy;

  InformationPage({
    required this.name,
    required this.age,
    required this.drugAllergy,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Information'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: $name', style: TextStyle(fontSize: 18)),
                        Text('Age: $age', style: TextStyle(fontSize: 18)),
                        Text('Drug Allergy: $drugAllergy',
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
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

class Profile {
  String name;
  String age;
  String drugAllergy;

  Profile({
    required this.name,
    required this.age,
    required this.drugAllergy,
  });
}

class ProfileModel extends ChangeNotifier {
  Profile _profile = Profile(name: '', age: '', drugAllergy: '');

  Profile get profile => _profile;

  void updateProfile(String name, String age, String drugAllergy) {
    _profile = Profile(name: name, age: age, drugAllergy: drugAllergy);
    notifyListeners();
  }
}
