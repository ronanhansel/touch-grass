import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'bg',
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                backgroundColor: Theme.of(context).colorScheme.primary,
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      LineIcons.arrowLeft,
                      color: Colors.black,
                    )),
                title: Text(
                  '0 Tasks saved!',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      )),
                ],
              )
            ],
          )),
    );
  }
}
