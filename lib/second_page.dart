import 'package:flutter/material.dart';
import 'package:pobpad/choice_card.dart';

class SecondPage extends StatefulWidget {
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> _medicationNameList = ['Omega 3', 'CoQ10', 'Astaxanthin'];
  String? _medicationName;

  String? validateTextFormField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please add a medication name.';
    }
    if (_medicationNameList.contains(value)) {
      return 'This medication has already been added.';
    }
    return null;
  }

  void navigateToNextPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          MedicationTypePage(medicationName: _medicationName!),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/medication.png',
                height: 80,
              ),
              Text(
                'Medication Name',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    hintText: 'Add Medication Name',
                  ),
                  validator: validateTextFormField,
                  onChanged: (value) {
                    setState(() {
                      _medicationName = value;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    navigateToNextPage();
                  }
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 170.0),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicationTypePage extends StatefulWidget {
  final String medicationName;

  MedicationTypePage({required this.medicationName});

  @override
  State<MedicationTypePage> createState() => _MedicationTypePageState();
}

class _MedicationTypePageState extends State<MedicationTypePage> {
  int medicationType = 0;
  int unit = 0;
  String? strength;

  final List<String> listMedicationType = <String>[
    'Capsule',
    'Tablet',
    'Softgel',
    'Liquid',
  ];

  final List<String> listUnit = <String>[
    'mg',
    'mcg',
    'g',
    'mL',
  ];

  String? validateStrength(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please add strength';
    }
    return null;
  }

  void navigateToSelectTimePage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SelectTimePage(
        medicationName: widget.medicationName,
        strength: strength!,
        forms: listMedicationType[medicationType],
        unit: listUnit[unit],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication Type'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Strength',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    hintText: 'Add Strength',
                  ),
                  validator: validateStrength,
                  onChanged: (value) {
                    setState(() {
                      strength = value;
                    });
                  },
                ),
              ),
              ChoiceCard(
                choiceData: ChoiceData(
                  title: 'Forms',
                  choices: listMedicationType,
                  groupValue: medicationType,
                  onChanged: (int newValue) {
                    setState(() {
                      medicationType = newValue;
                    });
                  },
                ),
              ),
              ChoiceCard(
                choiceData: ChoiceData(
                  title: 'Unit',
                  choices: listUnit,
                  groupValue: unit,
                  onChanged: (int newValue) {
                    setState(() {
                      unit = newValue;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (medicationType != 0 && unit != 0 && strength != null) {
                    navigateToSelectTimePage();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Please add strength and select a medication type, unit.'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 170.0),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectTimePage extends StatefulWidget {
  final String medicationName;
  final String strength;
  final String forms;
  final String unit;

  SelectTimePage({
    required this.medicationName,
    required this.strength,
    required this.forms,
    required this.unit,
  });

  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTimePage> {
  List<String> times = ['Morning', 'Afternoon', 'Evening', 'Night'];
  List<String> selectedTimes = [''];

  void navigateToConfirmationPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ListMedicationPage(
        medicationName: widget.medicationName,
        strength: widget.strength,
        forms: widget.forms,
        unit: widget.unit,
        selectedTimes: selectedTimes,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Time'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Select Times',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: times.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(times[index]),
                    value: selectedTimes.contains(times[index]),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedTimes.add(times[index]);
                        } else {
                          selectedTimes.remove(times[index]);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedTimes.isNotEmpty) {
                  navigateToConfirmationPage();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select time'),
                    ),
                  );
                }
              },
              child: Text(
                'Next',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 170.0),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListMedicationPage extends StatelessWidget {
  final String medicationName;
  final String strength;
  final String forms;
  final String unit;
  final List<String> selectedTimes;

  ListMedicationPage({
    required this.medicationName,
    required this.strength,
    required this.forms,
    required this.unit,
    required this.selectedTimes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Medication'),
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
                      Text('Name: $medicationName',
                          style: TextStyle(fontSize: 18)),
                      Text('Forms: $forms', style: TextStyle(fontSize: 18)),
                      Text('Strength: $strength $unit',
                          style: TextStyle(fontSize: 18)),
                      Text('Times: ${selectedTimes.join('')}',
                          style: TextStyle(fontSize: 18)),
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


class ChoiceRadio extends StatelessWidget {
  const ChoiceRadio({
    super.key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final int groupValue;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<int>(
          groupValue: groupValue,
          value: value,
          onChanged: (int? newValue) {
            onChanged(newValue!);
          },
        ),
        Text(label),
      ],
    );
  }
}

class ChoiceData {
  const ChoiceData({
    required this.title,
    required this.choices,
    required this.groupValue,
    required this.onChanged,
  });

  final String title;
  final List<String> choices;
  final int groupValue;
  final ValueChanged<int> onChanged;
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({
    super.key,
    required this.choiceData,
  });

  final ChoiceData choiceData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
          children: List.generate(choiceData.choices.length + 1, (index) {
        if (index == 0) {
          return Text(choiceData.title);
        }
        return ChoiceRadio(
          label: choiceData.choices[index - 1],
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          value: index,
          groupValue: choiceData.groupValue,
          onChanged: (int newValue) {
            choiceData.onChanged(newValue);
          },
        );
      })),
    );
  }
}
