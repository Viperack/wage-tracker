import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddJobPage extends StatefulWidget {
  AddJobPage({super.key});

  TimeOfDay supplementaryPayStartTime = TimeOfDay.now();

  @override
  State<AddJobPage> createState() =>
      AddJobPageState(time: supplementaryPayStartTime);
}

class AddJobPageState extends State<AddJobPage> {
  TimeOfDay time;

  AddJobPageState({required this.time});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Hourly wage'),
                textInputAction: TextInputAction.next, // Moves focus to next.
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Hourly wage'),
                textInputAction: TextInputAction.next, // Moves focus to next.
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration:
                    InputDecoration(hintText: 'Supplementary pay amount'),
                textInputAction: TextInputAction.done, // Hides the keyboard.
              ),
            ),
            TimePicker(time: time),
          ],
        ),
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  TimeOfDay time;

  TimePicker({super.key, required this.time});

  @override
  State<AddJobPage> createState() => AddJobPageState(time: time);
}

class TimePickerState extends State<TimePicker> {
  TimeOfDay time;

  TimePickerState({required this.time});

  @override
  Widget build(BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("$hours:$minutes"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              setState(() async {
                time = (await showTimePicker(
                    context: context, initialTime: time))!;
              });
            },
            child: const Text("Starting time for supplementary pay"),
          ),
        ),
      ],
    );
  }
}
