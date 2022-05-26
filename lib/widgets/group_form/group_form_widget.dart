import 'package:flutter/material.dart';
import 'package:weather/widgets/group_form/group_form_widget_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({Key? key}) : super(key: key);

  @override
  State<GroupFormWidget> createState() => _GroupFormWidgetState();
}

class _GroupFormWidgetState extends State<GroupFormWidget> {
  final model = GroupFormWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvider(
        model: model, child: const _GroupFormWidgetBody());
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Group')),
      body: Center(
        child: Container(
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _GroupNameWidget()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GroupFormWidgetModelProvider.of(context)
            ?.model
            .saveGroup(context), //read
        child: Icon(Icons.done),
      ),
    );
  }
}

class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.of(context)?.model;
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: 'Name of Group',
      ),
      onChanged: (value) => model?.groupName = value,
      onEditingComplete: () => model?.saveGroup(context),
    );
  }
}
