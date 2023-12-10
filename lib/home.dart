import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final CardSwiperController controller = CardSwiperController();
  List<Text> cards = [Text('hiii'), Text('hiiiiii')];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CardSwiper(
        cardsCount: cards.length,
        cardBuilder: cardBuilder,
        controller: controller,
        onSwipe: _onSwipe,
        allowedSwipeDirection: AllowedSwipeDirection.only(
            up: false, down: false, left: true, right: true),
        numberOfCardsDisplayed: 2,
      ),
    );
  }
}

Widget cardBuilder(context, index, percentThresholdX, percentThresholdY) {
  double opacity = normaliser(percentThresholdX, 1000, -1000);
  // debugPrint('$percentThresholdX');
  return Center(
    child: Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(238, 240, 227, 100),
          ),
          color: Colors.yellow[100], //Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.10),
              spreadRadius: 0,
              blurRadius: 3,
              offset: Offset(1, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: convertR(true, opacity),
              duration: Duration.zero,
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(238, 240, 227, 100),
                    ),
                    color: Color.fromARGB(255, 241, 255,
                        92), //Theme.of(context).colorScheme.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.10),
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset: Offset(1, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                    child: Icon(
                  Icons.bookmark_add,
                  color: Colors.black,
                  size: 100,
                )),
              ),
            ),
            Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                  opacity: convertR(false, opacity),
                  duration: Duration.zero,
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(238, 240, 227, 100),
                        ),
                        color: Colors
                            .redAccent, //Theme.of(context).colorScheme.background,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.10),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: Offset(1, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 100,
                    ),
                  )),
            ),
          ],
        ),
      ),
    ),
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
