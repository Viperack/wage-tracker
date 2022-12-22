import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_job_page.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.workplace});
  final String workplace;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            // TODO: Make each JobCard direct to the right page
            debugPrint('${workplace} card tapped.');
            // Navigator.of(context).pushNamed("/add_job_page");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddJobPage()),
            );
          },
          child: SizedBox(
            width: 300,
            height: 200,
            child: Center(child: Text(workplace)),
          ),
        ),
      ),
    );
  }
}

