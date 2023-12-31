import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<List<String>> savedTasks = [
    ['Look at the sky', 'energy'],
    ['Walk 10 minutes', 'transportation'],
    ['Pick up 2 plastic bags', 'waste'],
    ['Prepare a "green" mean', 'consumption']
  ];
  List<List<String>> insights = [
    [
      'Energy saved!',
      'If you\'ve saved 200 grams of carbon, that would be the equivalent of charging your phone 3 times!'
    ],
    [
      'Water ~ energy',
      'Replacing one serving of bottled water with tap water saves ~80 grams of carbon. That\'s boiling water to make a cup of tea!'
    ]
  ];

  bool check = false;
  void changeCheck() {
    setState(() {
      check = check ? false : true;
    });
  }

  @override
  void initState() {
    // TODO: implement getting real data from firebase.

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 100,
            title: const DefaultTextStyle(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
              child: Text(
                'Touch Grass',
              ),
            ),
            leading: const BackButton(
              color: Colors.black,
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ))
            ]),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Insights',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: height * 0.25,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  insightCard(insights[0][0], insights[0][1], true),
                  Row(
                    children: List.generate(
                        insights.length - 1,
                        (index) => Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                insightCard(insights[index + 1][0],
                                    insights[index + 1][1], false),
                              ],
                            )),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Saved tasks',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: List.generate(
                  savedTasks.length,
                  (index) => TaskList(
                      taskName: savedTasks[index][0],
                      taskType: savedTasks[index][1])),
            )
          ],
        ));
  }
}
//Consumption: Blue; Transportation: Red; Energy: Yellow; Waste: Green

Widget insightCard(String title, String content, bool spotlight) {
  return Builder(builder: (context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Transform.scale(
      scale: spotlight ? 1 : 0.95,
      child: Container(
        height: height * 0.3,
        width: width * 0.6,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.10),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(1, 3), // changes position of shadow
              ),
            ],
            border: Border.all(
              color: const Color.fromRGBO(238, 240, 227, 100),
            ),
            color: spotlight
                ? Color.fromRGBO(86, 97, 53, 1)
                : Color.fromRGBO(240, 240, 212, 1),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width * 0.1,
                height: width * 0.1,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(240, 240, 212, 1),
                    borderRadius: BorderRadius.all(Radius.circular(360))),
                child: const Icon(
                  Icons.lightbulb_outline,
                  color: Color.fromRGBO(65, 73, 40, 1),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                title,
                style: TextStyle(
                  color: spotlight
                      ? Color.fromRGBO(240, 240, 212, 1)
                      : Color.fromRGBO(65, 73, 40, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                content,
                style: TextStyle(
                  color: spotlight
                      ? Color.fromRGBO(240, 240, 212, 1)
                      : Color.fromRGBO(65, 73, 40, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  });
}

class TaskList extends StatefulWidget {
  final String taskName;
  final String taskType;
  const TaskList({Key? key, required this.taskName, required this.taskType})
      : super(key: key);
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width * 0.95,
            height: height * 0.07,
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(238, 240, 227, 100),
                ),
                color: Theme.of(context).colorScheme.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.10),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: const Offset(1, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (!states.contains(MaterialState.selected)) {
                                return Colors.grey[100];
                              } else {
                                return null;
                              }
                            }),
                            checkColor: Colors.white,
                            value: check,
                            onChanged: (state) {
                              setState(() {
                                check = check ? false : true;
                              });
                            },
                          )),
                      Text(
                        widget.taskName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Container(
                      width: 5,
                      decoration: BoxDecoration(
                          color: switch (widget.taskType) {
                            //Consumption: Blue; Transportation: Red;
                            //Energy: Yellow; Waste: Green
                            'consumption' => Colors.blue,
                            'transportation' => Colors.red,
                            'energy' => Colors.yellow[600],
                            'waste' => Colors.green,
                            String() => null
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 1,
          )
        ],
      ),
    );
  }
}
