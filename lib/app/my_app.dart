import 'package:flutter/material.dart';

import 'package:weather/widgets/group_form/group_form_widget.dart';
import '../widgets/groups/group_widgets.dart';
import '../widgets/task/task_widget.dart';
import '../widgets/task_form/task_form_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        '/groups': (context) => GroupsWidget(),
        '/groups/form': (context) => const GroupFormWidget(),
        '/groups/task': (context) => const TaskWidget(),
        '/groups/task/form': (context) => TaskFormWidget(),
      },
      initialRoute: '/groups',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
