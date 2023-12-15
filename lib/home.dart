import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final CardSwiperController controller = CardSwiperController();
  List<Text> cards = [const Text('hiii'), const Text('hiiiiii')];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: CardSwiper(
          cardsCount: cards.length,
          cardBuilder: cardBuilder,
          controller: controller,
          onSwipe: _onSwipe,
          allowedSwipeDirection: AllowedSwipeDirection.only(
              up: false, down: true, left: true, right: true),
          numberOfCardsDisplayed: 2,
        ),
      ),
    );
  }
}

Widget cardBuilder(context, index, percentThresholdX, percentThresholdY) {
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
                  image: const DecorationImage(
                      image: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1200px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg'),
                      fit: BoxFit.fitHeight),
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Look at the sky',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Energy',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex.')
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
                            offset: const Offset(1, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(20))),
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

// void movedown(Context context, delta) {
//   setState();
// }

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

double normaliser(current, max, min) {
  double speed = 5;
  var z = (((current - min) / (max - min)) * 2 - 1) * speed;
  return z;
}

bool _onSwipe(
  int previousIndex,
  int? currentIndex,
  CardSwiperDirection direction,
) {
  debugPrint('The card $previousIndex was swiped $direction to $currentIndex');
  if (direction == CardSwiperDirection.left) {
    debugPrint('Left function');
  } else if (direction == CardSwiperDirection.right) {
    debugPrint('Right function');
  }
  return true;
}
