import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:superhero/superhero_api/hero_model.dart';
import 'package:superhero/superhero_api/superhero_api.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../constants.dart';
import '../details_page/details_page.dart';
import '../widgets/widgets.dart';
import 'home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isLoading = false;
  List superHeroList = [];
  List superHeroSuggestionList = [];
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  bool isClickOnSearch = false;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    getAllHeroesList();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    animation.addListener(() {
      setState(() {});
    });
  }

  Future<void> getAllHeroesList() async {
    superHeroList = await getHeroes();

    if (superHeroList.isNotEmpty) {
      for (int i = 0; i < superHeroList.length; i++) {
        _swipeItems.add(SwipeItem());
      }
    }
    setState(() {
     isLoading = false;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black54,
      extendBody: true,
      body: !isLoading
          ? Stack(
              children: [
                SwipeCards(
                  matchEngine: _matchEngine,
                  itemBuilder: (BuildContext context, int index) {
                    HeroInfo item = HeroInfo.fromJson(superHeroList[index]);
                    return HeroCard(item: item, index: index);
                  },
                  onStackFinished: () {},
                  itemChanged: (SwipeItem item, int index) {},
                  upSwipeAllowed: true,
                  fillSpace: true,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        Align(
                          alignment: const Alignment(-0.9, 0),
                          child: Opacity(
                            opacity: 1 - animation.value * animation.value,
                            child: Text(
                              'Explore\nSuper Hero',
                              style: TextStyle(
                                  fontSize: 40 * (1 - animation.value),
                                  color: kSearchColor),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.9, 0),
                          child: GestureDetector(
                            onTap: () {
                              isClickOnSearch = !isClickOnSearch;
                              isClickOnSearch
                                  ? controller.forward()
                                  : controller.reverse();
                              textController.text = "";
                              superHeroSuggestionList = [];
                            },
                            child: Container(
                              width: 70 + size.width * animation.value,
                              height: 110 - animation.value * 45,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: kSearchColor, width: 5),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Container(
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
                                          superHeroSuggestionList = [];
                                          if (superHeroList.isNotEmpty) {
                                            for (int i = 0;
                                                i < superHeroList.length;
                                                i++) {
                                              String heroName =
                                                  HeroInfo.fromJson(
                                                          superHeroList[i])
                                                      .name
                                                      .toLowerCase();
                                              if (heroName.contains(
                                                  text.toLowerCase())) {
                                                superHeroSuggestionList
                                                    .add(superHeroList[i]);
                                              }
                                            }
                                            setState(() {});
                                          }
                                        },
                                        controller: textController,
                                        enabled: isClickOnSearch,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          hintText: "Search",
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              decoration: TextDecoration.none),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 25,
                  left: 25,
                  top: size.height * kSearchContainerPercent,
                  child: Opacity(
                    opacity: (0.5 + animation.value).clamp(0, 1),
                    child: Container(
                      height: (size.height -
                              size.height * kSearchContainerPercent -
                              20) *
                          animation.value,
                      width: size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: kSearchColor, width: 5),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30)),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: superHeroSuggestionList.length,
                          itemBuilder: (context, index) {
                            HeroInfo item = HeroInfo.fromJson(
                                superHeroSuggestionList[index]);
                            return GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      child: HeroDetailsPage(item: item),
                                      inheritTheme: true,
                                      ctx: context),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                child: Row(

                                  children: [
                                    CachedNetworkImage(
                                      fit: BoxFit.contain,
                                      imageUrl: item.images.sm,
                                      placeholder: (context, url) =>
                                          const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: kCircularAvatarSize * 0.35,
                                        backgroundImage: ExactAssetImage(
                                            'lib/assets/images/loading.gif'),
                                      ),
                                      imageBuilder: (context, image) =>
                                          CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        foregroundImage: image,
                                        radius: kCircularAvatarSize * 0.35,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                          color: kSearchColor, fontSize: 22),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            )
          : const SlashScreen(),
    );
  }
}
