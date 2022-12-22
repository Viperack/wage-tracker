import 'job.dart';
import 'supplementary_pay.dart';
import 'jobs_supplementary_pay_rel.dart';
import 'home/add_job_page.dart';
import 'home/job_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create databases
  final jobsDatabase = openDatabase(
    join(await getDatabasesPath(), 'jobs_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE jobs(id INTEGER PRIMARY KEY, name TEXT, hourlyWage INTEGER, supplementaryPayId INTEGER)',
      );
    },
    version: 1,
  );

  final supplementaryPayDatabase = openDatabase(
    join(await getDatabasesPath(), 'supplementary_pay_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE supplementary_pay(id INTEGER PRIMARY KEY, supplementaryPay INTEGER, supplementaryPayStartTime INTEGER, supplementaryPayEndTime INTEGER)',
      );
    },
    version: 1,
  );

  final jobsSupplementaryPayRel = openDatabase(
    join(await getDatabasesPath(), 'jobs_supplementary_pay_rel_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE supplementary_pay(id INTEGER PRIMARY KEY, jobId INTEGER, supplementaryPayId INTEGER)',
      );
    },
    version: 1,
  );

  List<String> workplaces = ["OKQ8", "Budbee"];
  runApp(MyApp(workplaces: workplaces));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required List<String> this.workplaces});

  final List<String> workplaces;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(workplaces: workplaces),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required List<String> this.workplaces});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final List<String> workplaces;

  @override
  State<MyHomePage> createState() => HomePageState(workplaces: workplaces);
}

class HomePageState extends State<MyHomePage> {
  final List<String> workplaces;

  HomePageState({required List<String> this.workplaces});

  late final int numOfWorkplaces = workplaces.length;

  @override
  Widget build(BuildContext context) {
    const title = 'Jobs';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: Column(
          children: [
            Flexible(
              child: GridView.count(
                // Creates a grid with 2 columns.
                crossAxisCount: 2,
                children: List.generate(numOfWorkplaces + 1, (index) {
                  return JobCard(
                      workplace: (index != numOfWorkplaces)
                          ? workplaces[index]
                          : "Add new job");
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

 */
