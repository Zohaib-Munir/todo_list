import 'package:flutter/material.dart';

class ItemsList extends StatelessWidget {
  final String task;
  final Function onDelete;
  final Function onUpdate;
  const ItemsList(
      {super.key,
      required this.task,
      required this.onDelete,
      required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 20, 165, 198),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(task),
        leading: const Icon(
          Icons.add_task_outlined,
          color: Color.fromARGB(255, 20, 165, 198),
        ),
        dense: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {
                onDelete(task);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                onUpdate(task);
              },
              icon: const Icon(
                Icons.update,
                color: Color.fromARGB(255, 20, 165, 198),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
