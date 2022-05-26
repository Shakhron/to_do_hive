import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:weather/domain/entity/task.dart';

import '../../domain/entity/group.dart';

class TaskWidgetModel extends ChangeNotifier {
  int groupKey;
  late final Future<Box<Group>> _groupBox;
  Group? _group;
  Group? get group => _group;

  var _tasks = <Task>[];
  List<Task> get tasks => _tasks.toList();

  TaskWidgetModel({required this.groupKey}) {
    setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/groups/task/form', arguments: groupKey);
  }

  void loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _readTasks() {
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void _setupListenTasks() async {
    final box = await _groupBox;
    _readTasks();
    box.listenable(keys: [groupKey]).addListener(_readTasks);
  }

  void deleteTask(int groupIndex) {
    _group?.tasks?.deleteFromHive(groupIndex);
  }

  void setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    Hive.openBox<Task>('tasks_box');
    _groupBox = Hive.openBox<Group>('groups_box');
    loadGroup();
    _setupListenTasks();
  }
}

class TaskWidgetModelProvider extends InheritedNotifier {
  final TaskWidgetModel model;
  const TaskWidgetModelProvider(
      {Key? key, required this.child, required this.model})
      : super(key: key, child: child);

  final Widget child;

  static TaskWidgetModelProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskWidgetModelProvider>();
  }

  @override
  bool updateShouldNotify(TaskWidgetModelProvider oldWidget) {
    return true;
  }
}
