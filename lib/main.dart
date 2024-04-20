import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Symptom Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SymptomTracker(),
    );
  }
}

class SymptomTracker extends StatefulWidget {
  @override
  _SymptomTrackerState createState() => _SymptomTrackerState();
}

class _SymptomTrackerState extends State<SymptomTracker> {
  List<Map<String, dynamic>> _symptomHistory = [];

  void _trackSymptoms({int? painLevel, int? fatigueLevel, String? mood}) {
    setState(() {
      _symptomHistory.add({
        'painLevel': painLevel,
        'fatigueLevel': fatigueLevel,
        'mood': mood,
        'timestamp': DateTime.now(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Pain level'),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                _trackSymptoms(painLevel: int.parse(value));
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Fatigue level'),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                _trackSymptoms(fatigueLevel: int.parse(value));
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Mood'),
              onSubmitted: (value) {
                _trackSymptoms(mood: value);
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Symptom History'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _symptomHistory.map((symptom) {
                            String painLevel = symptom['painLevel'] != null
                                ? 'Pain: ${symptom['painLevel']}, '
                                : '';
                            String fatigueLevel =
                                symptom['fatigueLevel'] != null
                                    ? 'Fatigue: ${symptom['fatigueLevel']}, '
                                    : '';
                            String mood = symptom['mood'] != null
                                ? 'Mood: ${symptom['mood']}, '
                                : '';
                            String timestamp = symptom['timestamp'] != null
                                ? 'Date: ${symptom['timestamp'].toString().substring(0, 16)}'
                                : '';
                            return ListTile(
                              title: Text('$painLevel$fatigueLevel$mood'),
                              subtitle: Text(timestamp),
                            );
                          }).toList(),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Show Symptom History'),
            ),
          ],
        ),
      ),
    );
  }
}
