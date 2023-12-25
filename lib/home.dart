import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:gdsc_solution/navigation.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  final Function changeIndex;

  const Home(this.changeIndex, {super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CardSwiperController controller = CardSwiperController();
  List<List<String>> cardsContent = [
    [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1200px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg',
      'Look at the sky',
      'Energy',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex.'
    ],
    [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project.jpg/1200px-Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project.jpg',
      'Look at yourself',
      'Consumption',
      'Description'
    ],
    [
      'https://www.artchive.com/wp-content/uploads/2023/04/Self-Portrait-with-Dark-Felt-Hat-VAN-GOGH-Vincent-1886-2-scaled.jpg',
      'Look at me',
      'Transportation',
      'Description'
    ],
    [
      'https://ka-perseus-images.s3.amazonaws.com/653f09fedc305ad96ff0f7272df19fa7624f3c7e.jpg',
      'Lmao stop',
      'Lmao',
      'LMAMAMAMAOAOO'
    ]
  ];

  bool _toggle = false;
  void changeToggle() {
    setState(() {
      _toggle = _toggle ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int nTask = 0;
    List<Widget> cards = [for (var i in cardsContent) Text(i.toString())];
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CardSwiper(
              cardsCount: cards.length,
              cardBuilder: (context, index, percentThresholdX,
                      percentThresholdY) =>
                  cardBuilder(
                      context,
                      percentThresholdX,
                      percentThresholdY,
                      cardsContent[index][0],
                      cardsContent[index][1],
                      cardsContent[index][2],
                      cardsContent[index][3]),
              controller: controller,
              onSwipe: (
                previousIndex,
                currentIndex,
                direction,
              ) =>
                  _onSwipe(previousIndex, currentIndex, direction,
                      widget.changeIndex, changeToggle),
              allowedSwipeDirection: AllowedSwipeDirection.only(
                  up: false, down: true, left: true, right: true),
              numberOfCardsDisplayed: cards.length,
              isLoop: false,
            ),
            Positioned(
              top: height * 0.02,
              left: width * 0.5 - 200 / 2,
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.10),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: const Offset(3, 3), // changes position of shadow
                    ),
                  ],
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '$nTask Tasks saved!',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black),
                  )
                ]),
              )
                  .animate(target: _toggle ? 1 : 0)
                  .shake(duration: 500.milliseconds, hz: 10)
                  .shimmer(),
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    type,
                    style: TextStyle(fontSize: 18),
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
//.animate(controller: ).fadeOut(delay: 4000.ms, duration: 300.ms, curve: Curves.easeIn);
}

Widget card() {
  return Container();
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
) {
  debugPrint('The card $previousIndex was swiped $direction to $currentIndex');
  if (direction == CardSwiperDirection.left) {
    debugPrint('Left function');
  } else if (direction == CardSwiperDirection.right) {
    debugPrint('Right function');
    changeToggle();
  } else if (direction == CardSwiperDirection.bottom) {
    debugPrint('Bottom function');
    downFunction(3);
  }
  return true;
}
