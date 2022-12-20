import 'job.dart';
import 'supplementary_pay.dart';
import 'home/add_job_page.dart';
import 'home/job_card.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final jobsDatabase = openDatabase(
    join(await getDatabasesPath(), 'jobs_database.db'),

    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE jobs(id INTEGER PRIMARY KEY, name TEXT, hourlyWage INTEGER, supplementaryPayId INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  final supplementaryPayDatabase = openDatabase(
    join(await getDatabasesPath(), 'supplementary_pay_database.db'),

    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE supplementary_pay(id INTEGER PRIMARY KEY, supplementaryPay INTEGER, supplementaryPayStartTime INTEGER, supplementaryPayEndTime INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  /*
  final int id;
  final String name;
  final int hourlyWage;
  final int supplementaryPayId;

  final int id;
  final int supplementaryPay;
  final int supplementaryPayStartTime;
  final int supplementaryPayEndTime;
   */

  List<String> workplaces = ["OKQ8", "Budbee"];
  runApp(MaterialApp(
      home: MyApp(workplaces: workplaces),
      routes: <String, WidgetBuilder>{
        "/add_job_page": (BuildContext context) => AddJobPage(),
      }));
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
    const title = 'Grid List';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: GridView.count(
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
    );
  }
}
