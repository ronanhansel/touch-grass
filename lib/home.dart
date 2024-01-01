import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:gdsc_solution/tasks.dart';
import 'package:line_icons/line_icons.dart';
import 'package:gdsc_solution/provider/tasks_provider.dart';

class Home extends StatefulWidget {
  final Function changeIndex;

  const Home(this.changeIndex, {super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final CardSwiperController controller = CardSwiperController();
  late AnimationController rightSwipeController;
  late AnimationController leftSwipeController;
  late AnimationController buttonController;

  int nTask = 0;
  bool loaded = false;
  void changeToggle(bool right) {
    if (right) {
      setState(() {
        // rightSwipeController.reset();
        rightSwipeController
            .forward()
            .then((value) => rightSwipeController.reset());
        nTask += 1;
      });
    } else {
      setState(() {
        // leftSwipeController.reset();
        leftSwipeController
            .forward()
            .then((value) => leftSwipeController.reset());
      });
    }
  }

  Future<List> getCardInfo() async {
    // final String response =
    //     await rootBundle.loadString('assets/data/retrieved_tasks.json');
    // final data = await json.decode(response);
    final tasks = await fetchData();
    print(tasks);
    return tasks;
  }
  

  List<dynamic> cardInfo = [''];
  @override
  void initState() {
    rightSwipeController = AnimationController(vsync: this);
    leftSwipeController = AnimationController(vsync: this);
    buttonController = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cardInfo = await getCardInfo();
      print(cardInfo.length);
      print(cardInfo[0]);
      if (cardInfo.isNotEmpty) {
        setState(() {
          loaded = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    rightSwipeController.dispose();
    leftSwipeController.dispose();
    buttonController.dispose();
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // List<Widget> cards = [for (var i in cardInfo) Text(i.toString())];
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            loaded
                ? CardSwiper(
                    cardsCount: cardInfo.length,
                    cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) =>
                        cardBuilder(
                            context,
                            percentThresholdX,
                            percentThresholdY,
                            cardInfo[index]['photo'],
                            cardInfo[index]['name'],
                            cardInfo[index]['type'],
                            cardInfo[index]['xp'],
                            cardInfo[index]['detail']),
                    controller: controller,
                    onSwipe: (
                      previousIndex,
                      currentIndex,
                      direction,
                    ) =>
                        _onSwipe(
                            previousIndex,
                            currentIndex,
                            direction,
                            widget.changeIndex,
                            changeToggle,
                            context,
                            const Tasks()),
                    allowedSwipeDirection: AllowedSwipeDirection.only(
                        up: false, down: true, left: true, right: true),
                    numberOfCardsDisplayed: (cardInfo.length >= 4) ? 4 : cardInfo.length,
                    isLoop: false,
                  )
                : const Center(child: CircularProgressIndicator()),
            Positioned(
              top: height * 0.02,
              left: width * 0.5 - (width * 0.5) / 2,
              child: GestureDetector(
                onTap: () {
                  buttonController.forward().then((value) => buttonController
                      .reverse()
                      .then((value) => buttonController.reset()));
                  Future.delayed(const Duration(milliseconds: 240), () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Tasks()));
                  });
                },
                child: Container(
                  height: height * 0.08,
                  width: width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.10),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset:
                            const Offset(3, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultTextStyle(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                          child: Text(
                            '$nTask Tasks saved!',
                          ),
                        ),
                      ]),
                )
                    .animate(controller: leftSwipeController, autoPlay: false)
                    .shake(duration: 300.milliseconds, hz: 6)
                    .animate(controller: rightSwipeController, autoPlay: false)
                    .shakeY(
                      duration: 300.milliseconds,
                      hz: 2,
                    )
                    .animate(controller: buttonController, autoPlay: false)
                    .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(0.90, 0.90),
                        curve: Curves.easeIn,
                        duration: 120.ms),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// context, index, percentThresholdX, percentThresholdY
Widget cardBuilder(
  context,
  percentThresholdX,
  percentThresholdY,
  String imgLink,
  String title,
  String type,
  int xp,
  String description,
) {
  double opacity = normaliser(percentThresholdX, 1000, -1000);
  double y_delta = normaliser(percentThresholdY, 1000, -1000);
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  double card_height = height * 0.60;
  double card_width = width * 0.95;
  return Stack(
    children: [
      Positioned(
        bottom: height * 0.05,
        left: 0,
        right: 0,
        child: Stack(
          children: [
            // This is the image container
            Container(
              // alignment: Alignment.center,
              height: card_height,
              width: card_width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imgLink), fit: BoxFit.fitHeight),
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground, //Theme.of(context).colorScheme.background,

                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            ),
            // This is gradient container
            Container(
              // alignment: Alignment.center,
              height: card_height,
              width: card_width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.0),
                        Colors.black.withOpacity(0.5),
                      ],
                      stops: const [
                        0.0,
                        0.75
                      ]),
                  border: Border.all(
                    color: const Color.fromRGBO(238, 240, 227, 100),
                  ),
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground, //Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            ),
            // This is the text container
            Container(
              // alignment: Alignment.center,
              height: card_height,
              width: card_width,
              decoration: const BoxDecoration(
                  //Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.only(
                  left: width * 0.05,
                  bottom: width * 0.05,
                  right: width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$type • $xp XP',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(description)
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: height * 0.05,
        left: 0,
        right: 0,
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: convertR(true, opacity),
              duration: Duration.zero,
              child: Container(
                alignment: Alignment.center,
                height: card_height,
                width: card_width,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onError, //Theme.of(context).colorScheme.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.10),
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset:
                            const Offset(1, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: const Center(
                    child: Icon(
                  LineIcons.heart,
                  color: Colors.white,
                  size: 100,
                )),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                  opacity: convertR(false, opacity),
                  duration: Duration.zero,
                  child: Container(
                    alignment: Alignment.center,
                    height: card_height,
                    width: card_width,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(238, 240, 227, 100),
                        ),
                        color: Theme.of(context)
                            .colorScheme
                            .error, //Theme.of(context).colorScheme.background,
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
                            const BorderRadius.all(Radius.circular(20))),
                    child: const Icon(
                      LineIcons.heartBroken,
                      color: Colors.white,
                      size: 100,
                    ),
                  )),
            ),
          ],
        ),
      ),
    ],
  );
}

double convertR(bool right, current) {
  if (right) {
    if (current < 0) {
      return 0;
    } else if (current > 1) {
      return 1;
    } else {
      return current;
    }
  } else {
    if (current > 0) {
      return 0;
    } else if (current < -1) {
      return 1;
    } else {
      return current.abs();
    }
  }
}

double convertY(current) {
  if (current < 0) {
    return 0;
  } else if (current > 1) {
    return 1;
  } else {
    return current;
  }
}

double normaliser(current, max, min) {
  double speed = 5;
  var z = (((current - min) / (max - min)) * 2 - 1) * speed;
  return z;
}

bool _onSwipe(
  int previousIndex,
  int? currentIndex,
  CardSwiperDirection direction,
  Function downFunction,
  Function changeToggle,
  BuildContext context,
  Widget destination,
) {
  debugPrint('The card $previousIndex was swiped $direction to $currentIndex');
  if (direction == CardSwiperDirection.left) {
    debugPrint('Left function');
    changeToggle(false);
    //TODO: Implement dismissing tasks.
  } else if (direction == CardSwiperDirection.right) {
    debugPrint('Right function');
    changeToggle(true);
    //TODO: Implement adding tasks.
  } else if (direction == CardSwiperDirection.bottom) {
    debugPrint('Bottom function');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destination));
    // downFunction(3);
  }
  return true;
}
