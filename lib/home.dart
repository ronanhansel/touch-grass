import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CardSwiperController controller = CardSwiperController();
  List<Text> cards = [Text('hiii'), Text('hiiiiii')];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Flexible(
        child: CardSwiper(
          cardsCount: cards.length,
          cardBuilder: cardBuilder,
          controller: controller,
          onSwipe: _onSwipe,
          allowedSwipeDirection: AllowedSwipeDirection.only(
              up: false, down: false, left: true, right: true),
          numberOfCardsDisplayed: 2,
        ),
      ),
    );
  }
}

Widget cardBuilder(context, index, percentThresholdX, percentThresholdY) {
  return Container(
    alignment: Alignment.center,
    child: Container(
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
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width * 0.95,
    ),
  );
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
