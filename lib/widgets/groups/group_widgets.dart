import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:weather/widgets/groups/group_widgets_model.dart';

class GroupsWidget extends StatefulWidget {
  GroupsWidget({Key? key}) : super(key: key);

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final model = GroupWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupWidgetModelProvider(
      model: model,
      child: const GroupWidgetBody(),
    );
  }
}

class GroupWidgetBody extends StatelessWidget {
  const GroupWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Группы'),
      ),
      body: const _GroupListwidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GroupWidgetModelProvider.of(context)?.model.showForm(context);
          // Navigator.of(context).pushNamed('/groups/form');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _GroupListwidget extends StatelessWidget {
  const _GroupListwidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        GroupWidgetModelProvider.of(context)?.model.groups.length ?? 0; // read
    return ListView.separated(
      itemCount: groupsCount,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return _GroupListRowWidget(
          indexInList: index,
        );
      },
    );
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const _GroupListRowWidget({Key? key, required this.indexInList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupWidgetModelProvider.of(context)!.model;
    final group = model.groups[indexInList];
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) => model.deleteGroup(indexInList),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(group.name),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            model.showTasks(context, indexInList);
          },
        ),
      ),
    );
  }
}
