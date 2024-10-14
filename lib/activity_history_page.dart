

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary of Activities'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Reset History'),
                    content: Text('Are you sure you want to reset the activity history?'),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Reset'),
                        onPressed: () {
                          context.read<ActivityModel>().clearHistory();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ActivityModel>(
          builder: (context, activityModel, child) {
            return activityModel.activityHistory.isEmpty
                ? Center(child: Text('No activity history available.'))
                : ListView.builder(
                    itemCount: activityModel.activityHistory.length,
                    itemBuilder: (context, index) {
                      final activities = activityModel.activityHistory[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('วันที่ ${index + 1}'),
                              Text('Walk or run 10,000 steps: ${activities['walk10kSteps']! ? '✔️' : '❌'}'),
                              Text('Drink at least 2 liters of water: ${activities['drink2LitersWater']! ? '✔️' : '❌'}'),
                              Text('Do 30 minutes of cardio exercise: ${activities['cardio30Mins']! ? '✔️' : '❌'}'),
                              Text('Avoid caffeine after 2 PM: ${activities['avoidCaffeine']! ? '✔️' : '❌'}'),
                              Text('Avoid processed foods and fast food: ${activities['avoidFastFood']! ? '✔️' : '❌'}'),
                              Text('Limit or avoid alcohol consumption: ${activities['limitAlcohol']! ? '✔️' : '❌'}'),
                              Text('Get 7-8 hours of sleep: ${activities['sleep7To8Hours']! ? '✔️' : '❌'}'),
                              Text('Limit screen time, especially before bed: ${activities['limitScreenTime']! ? '✔️' : '❌'}'),
                              Text('Have a healthy breakfast: ${activities['healthyBreakfast']! ? '✔️' : '❌'}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}



class ActivityModel extends ChangeNotifier {
  List<Map<String, bool>> _activityHistory = [];

  List<Map<String, bool>> get activityHistory => _activityHistory;

  ActivityModel() {
    loadActivities();
  }

  void addActivity(Map<String, bool> activity) {
    _activityHistory.add(activity);
    saveActivities();
    notifyListeners();
  }

  void clearHistory() {
    _activityHistory.clear();
    saveActivities();
    notifyListeners();
  }

  void saveActivities() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> activityList = _activityHistory.map((activity) {
      return activity.entries.map((e) => '${e.key}:${e.value}').join(',');
    }).toList();

    prefs.setStringList('activityHistory', activityList);
  }

  void loadActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? activityList = prefs.getStringList('activityHistory');

    if (activityList != null) {
      _activityHistory = activityList.map((activityString) {
        Map<String, bool> activityMap = {};
        List<String> entries = activityString.split(',');

        for (var entry in entries) {
          var keyValue = entry.split(':');
          activityMap[keyValue[0]] = keyValue[1] == 'true';
        }

        return activityMap;
      }).toList();

      notifyListeners();
    }
  }
}