import 'package:flutter/material.dart';

class AddJobPage extends StatefulWidget {
  AddJobPage({super.key});

  @override
  State<AddJobPage> createState() => AddJobPageState();
}

class AddJobPageState extends State<AddJobPage> {
  List<TimeOfDay> timeStart = [TimeOfDay.now()];
  List<TimeOfDay> timeEnd = [TimeOfDay.now()];
  int numberOfSupplementaryPays = 1;
  final controllerJobTitle = TextEditingController();
  final controllerHourlyWage = TextEditingController();
  final controllersSupplementaryPay = [TextEditingController()];
  String errorMessage = "";

  @override
  void disposeControllers() {
    // Clean up the controller when the widget is disposed.
    controllerJobTitle.dispose();
    controllerHourlyWage.dispose();
    for (var controller in controllersSupplementaryPay) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Add job';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView(
            children: (<Widget>[
                  if (errorMessage != "") ...[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          width: 200.0,
                          height: 40.0,
                          child: Center(
                              child: Flexible(
                            child: Text(errorMessage,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          )),
                        ),
                      ),
                    ),
                  ] else
                    ...[]
                ] +
                <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Job title'),
                      controller: controllerJobTitle,
                      textInputAction:
                          TextInputAction.next, // Moves focus to next.
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Hourly wage'),
                      controller: controllerHourlyWage,
                      textInputAction:
                          TextInputAction.next, // Moves focus to next.
                    ),
                  ),
                ] +
                List.generate(numberOfSupplementaryPays, (i) {
                  return SizedBox(
                    height: 203.0,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                                label: Text('Supplementary pay ${i + 1} size')),
                            textInputAction:
                                TextInputAction.done, // Hides the keyboard.
                          ),
                        ),
                        TimePicker(
                            time: timeStart[i],
                            title:
                                "Starting time for supplementary pay ${i + 1}"),
                        TimePicker(
                            time: timeEnd[i],
                            title:
                                "Ending time for supplementary pay ${i + 1}"),
                      ],
                    ),
                  );
                }) +
                <Widget>[
                  UnconstrainedBox(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          // style: ElevatedButton.styleFrom(minimumSize: const Size(10, 10)),
                          onPressed: () {
                            setState(() {
                              numberOfSupplementaryPays++;
                              timeStart.add(TimeOfDay.now());
                              timeEnd.add(TimeOfDay.now());
                              controllersSupplementaryPay
                                  .add(TextEditingController());
                            });
                          },
                          child: const Text('Add additional supplementary pay'),
                        ),
                      ),
                    ),
                  ),
                ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //TODO: Check if name is already in use,
            if (controllerJobTitle.text == "") {
              setState(() {
                errorMessage = "Job title is missing";
              });
            }

            if (controllerHourlyWage.text == "") {
              setState(() {
                errorMessage = "Hourly wage is  missing";
              });
            }
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
/*


 */

class TimePicker extends StatefulWidget {
  TimeOfDay time;
  final String title;

  TimePicker({super.key, required this.time, required this.title});

  @override
  State<TimePicker> createState() => TimePickerState(time: time, title: title);
}

class TimePickerState extends State<TimePicker> {
  TimeOfDay time;
  final String title;

  TimePickerState({required this.time, required this.title});

  @override
  Widget build(BuildContext context) {
    String hours = time.hour.toString().padLeft(2, '0');
    String minutes = time.minute.toString().padLeft(2, '0');

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("$hours:$minutes"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Future<TimeOfDay?> timeFuture =
                  showTimePicker(context: context, initialTime: time);
              timeFuture.then((value) => {
                    setState(() {
                      time = value!;
                    }),
                  });
            },
            child: Text(title),
          ),
        ),
      ],
    );
  }
}
