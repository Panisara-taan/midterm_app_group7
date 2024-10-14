

import 'package:flutter/material.dart';
import 'package:pobpad/activity_history_page.dart';
import 'package:provider/provider.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  bool walk10kSteps = false;
  bool drink2LitersWater = false;
  bool cardio30Mins = false;
  bool avoidCaffeine = false;
  bool avoidFastFood = false;
  bool limitAlcohol = false;
  bool sleep7To8Hours = false;
  bool limitScreenTime = false;
  bool healthyBreakfast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Activities'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CheckboxListTile(
              title: Text('Walk or run 10,000 steps'),
              value: walk10kSteps,
              onChanged: (value) {
                setState(() {
                  walk10kSteps = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Drink at least 2 liters of water'),
              value: drink2LitersWater,
              onChanged: (value) {
                setState(() {
                  drink2LitersWater = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Do 30 minutes of cardio exercise'),
              value: cardio30Mins,
              onChanged: (value) {
                setState(() {
                  cardio30Mins = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Avoid caffeine after 2 PM'),
              value: avoidCaffeine,
              onChanged: (value) {
                setState(() {
                  avoidCaffeine = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Avoid processed foods and fast food'),
              value: avoidFastFood,
              onChanged: (value) {
                setState(() {
                  avoidFastFood = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Limit or avoid alcohol consumption'),
              value: limitAlcohol,
              onChanged: (value) {
                setState(() {
                  limitAlcohol = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Get 7-8 hours of sleep'),
              value: sleep7To8Hours,
              onChanged: (value) {
                setState(() {
                  sleep7To8Hours = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Limit screen time, especially before bed'),
              value: limitScreenTime,
              onChanged: (value) {
                setState(() {
                  limitScreenTime = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Have a healthy breakfast'),
              value: healthyBreakfast,
              onChanged: (value) {
                setState(() {
                  healthyBreakfast = value ?? false;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<ActivityModel>().addActivity({
                  'walk10kSteps': walk10kSteps,
                  'drink2LitersWater': drink2LitersWater,
                  'cardio30Mins': cardio30Mins,
                  'avoidCaffeine': avoidCaffeine,
                  'avoidFastFood': avoidFastFood,
                  'limitAlcohol': limitAlcohol,
                  'sleep7To8Hours': sleep7To8Hours,
                  'limitScreenTime': limitScreenTime,
                  'healthyBreakfast': healthyBreakfast,
                });

                Navigator.pushNamed(context, '/page2');
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}