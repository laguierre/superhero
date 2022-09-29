import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SlashScreen extends StatelessWidget {
  const SlashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: -50,
              child: SizedBox(
                height: 400,
                child: FadeInLeft(
                  duration: const Duration(milliseconds: 100),
                  child: Image.asset(
                    'lib/assets/images/dc wallpaper.png',
                  ),
                ),
              ),
            ),
            Positioned(
              left: -50,
              right: -50,
              top: 20,
              child: FadeInRight(
                duration: const Duration(milliseconds: 50),
                child: Image.asset(
                  'lib/assets/images/av wallpaper.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: FadeInUp(
                  duration: const Duration(milliseconds: 50),
                  child: SizedBox(
                      height: 80,
                      child:
                      Image.asset('lib/assets/images/white_inf.gif')),
                )),
            Align(
              alignment: const Alignment(0, 0.03),
              child: FadeInLeftBig(
                duration: const Duration(milliseconds: 50),
                child: Text('SuperHero\nAPI',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kSearchColor, fontSize: 70)),
              ),
            ),
          ],
        ));
  }
}

class CustomFieldText extends StatelessWidget {
  const CustomFieldText({
    Key? key,
    required this.enabled,
    required this.textController,
    required this.superHeroList,
    required this.superHeroSuggestionList,
  }) : super(key: key);

  final bool enabled;
  final TextEditingController textController;
  final List superHeroList, superHeroSuggestionList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      height: 45,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              Icons.search,
              color: kSearchColor,
              size: 40,
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (text) {
                for (int i = 0; i < superHeroList.length; i++) {
                  print(superHeroSuggestionList.length);
                  if (superHeroList.contains(text)) {
                    superHeroSuggestionList.add(superHeroList[i]);
                  }
                }
              },
              controller: textController,
              enabled: enabled,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(
                    color: Colors.grey, decoration: TextDecoration.none),
                contentPadding:
                EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 20.0,
                decoration: TextDecoration.none,
                color: kSearchColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}