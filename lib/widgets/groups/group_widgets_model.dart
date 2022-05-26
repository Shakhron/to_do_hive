import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../../domain/entity/group.dart';

class GroupWidgetModel extends ChangeNotifier {
  var _groups = <Group>[];
  List<Group> get groups => _groups.toList();

  GroupWidgetModel() {
    _setup();
  }

  void deleteGroup(int groupIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    await box.deleteAt(groupIndex);
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/groups/form');
  }

  void showTasks(BuildContext context, int groupIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    final groupKey = box.keyAt(groupIndex) as int;

    Navigator.of(context).pushNamed('/groups/task', arguments: groupKey);
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    _groups = box.values.toList();
    notifyListeners();
    box.listenable().addListener(() {
      _groups = box.values.toList();
      notifyListeners();
    });
  }
}

class GroupWidgetModelProvider extends InheritedNotifier {
  final GroupWidgetModel model;
  const GroupWidgetModelProvider(
      {Key? key, required this.child, required this.model})
      : super(key: key, notifier: model, child: child);

  final Widget child;

  static GroupWidgetModelProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupWidgetModelProvider>();
  }

  @override
  bool updateShouldNotify(GroupWidgetModelProvider oldWidget) {
    return true;
  }
}
