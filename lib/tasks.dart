import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool check = false;
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
                  icon: Icon(
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
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                height: height * 0.25,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      height: height * 0.27,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(238, 240, 227, 100),
                          ),
                          color: Color.fromRGBO(86, 97, 53,
                              1), //Theme.of(context).colorScheme.background,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: width * 0.1,
                              height: width * 0.1,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(240, 240, 212, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(360))),
                              child: Icon(Icons.lightbulb_outline),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Did you know?',
                              style: TextStyle(
                                color: Color.fromRGBO(240, 240, 212, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const Text(
                              'You\'ve saved 200 grams of carbon, the equivalent of charging your phone 3 times!',
                              style: TextStyle(
                                color: Color.fromRGBO(240, 240, 212, 1),
                                fontSize: 15,
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
                  ],
                ),
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
            Center(
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
                            offset: const Offset(
                                1, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
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
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (!states
                                          .contains(MaterialState.selected)) {
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
                              const Text(
                                'Look at the sky',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Container(
                              width: 5,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
