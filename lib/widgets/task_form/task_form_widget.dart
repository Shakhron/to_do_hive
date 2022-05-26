import 'package:flutter/material.dart';
import 'package:weather/widgets/task_form/task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({Key? key}) : super(key: key);

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TaskFormWidgetModel? _model;
  @override
  void didChangeDependencies() {
    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskFormWidgetModel(groupKey: groupKey);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(
      model: _model!,
      child: const _TextFormWidgetBody(),
    );
  }
}

class _TextFormWidgetBody extends StatelessWidget {
  const _TextFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Task')),
      body: Center(
        child: Container(
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _TaskTextWidget()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => TaskFormWidgetModelProvider.of(context)
            ?.model
            .saveTask(context), //read
        child: Icon(Icons.done),
      ),
    );
  }
}

class _TaskTextWidget extends StatelessWidget {
  const _TaskTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.of(context)?.model;
    return TextField(
      autofocus: true,
      maxLines: null,
      minLines: null,
      expands: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Task',
      ),
      onChanged: (value) => model?.taskText = value,
      onEditingComplete: () => model?.saveTask(context),
    );
  }
}
