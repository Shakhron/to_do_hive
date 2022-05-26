import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:weather/widgets/task/task_widget_model.dart';

import '../../task/task_widget_model.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TaskWidgetModel? _model;

  @override
  void didChangeDependencies() {
    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskWidgetModel(groupKey: groupKey);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    if (model != null) {
      return TaskWidgetModelProvider(model: model, child: TaskwidgetBody());
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class TaskwidgetBody extends StatelessWidget {
  const TaskwidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.of(context)?.model;
    final title = model?.group?.name ?? "Задачи";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const _TaskListwidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

class _TaskListwidget extends StatelessWidget {
  const _TaskListwidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        TaskWidgetModelProvider.of(context)?.model.tasks.length ?? 0; // read
    return ListView.separated(
      itemCount: groupsCount,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return _TaskListRowWidget(
          indexInList: index,
        );
      },
    );
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  const _TaskListRowWidget({Key? key, required this.indexInList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.of(context)!.model;
    final task = model.tasks[indexInList];
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) => model.deleteTask(indexInList),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(task.text),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
      ),
    );
  }
}
