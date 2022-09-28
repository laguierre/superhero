import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:superhero/constants.dart';
import 'package:superhero/pages/details_page/widget_details_page.dart';
import 'package:superhero/superhero_api/hero_model.dart';

class HeroDetailsPage extends StatefulWidget {
  const HeroDetailsPage({Key? key, required this.item}) : super(key: key);
  final HeroInfo item;

  @override
  State<HeroDetailsPage> createState() => _HeroDetailsPageState();
}

class _HeroDetailsPageState extends State<HeroDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool trigger = false;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        trigger = true;
      });
    });

    isExpanded = false;
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: trigger ? 0 : size.height),
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: linearGradient,
            ),
            child: ClipPath(
              clipper: DiagonalClipPath(),
              child: CachedNetworkImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.contain,
                imageUrl: widget.item.images.md,
                placeholder: (context, url) => Stack(children: [
                  Align(
                    alignment: const Alignment(0, -0.35),
                    child: Image.asset('lib/assets/images/loading.gif'),
                  )
                ]),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.56,
            left: 20,
            right: 20,
            child: AutoSizeText(
              widget.item.name,
              style: TextStyle(fontSize: 50, color: kSearchColor),
              minFontSize: 40,
              stepGranularity: 1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: size.height * 0.65,
            bottom: 0,
            child: ExpandableTheme(
              data: const ExpandableThemeData(
                iconColor: Colors.black54,
                iconSize: 35,
                useInkWell: true,
              ),
              child: ListView(
                padding: const EdgeInsets.all(0),
                physics: const BouncingScrollPhysics(),
                children: [
                  FadeInLeft(
                    duration: const Duration(milliseconds: kDurationDetails),
                    child: CardCategoryInfo(
                      widget: widget,
                      colorContainerTop: Colors.blueAccent,
                      textCategory: "Biography",
                      widgetCategory: Biography(
                        heroItem: widget.item,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FadeInLeft(
                    duration:
                        const Duration(milliseconds: kDurationDetails + 100),
                    child: CardCategoryInfo(
                      widget: widget,
                      colorContainerTop: Colors.purple,
                      textCategory: "Appearance",
                      widgetCategory: Appearance(
                        heroItem: widget.item,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FadeInLeft(
                    duration:
                        const Duration(milliseconds: kDurationDetails + 200),
                    child: CardCategoryInfo(
                      widget: widget,
                      colorContainerTop: Colors.orangeAccent,
                      textCategory: "Work",
                      widgetCategory: Work(
                        heroItem: widget.item,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FadeInLeft(
                      duration:
                          const Duration(milliseconds: kDurationDetails + 300),
                      child: CardCategoryInfo(
                        widget: widget,
                        colorContainerTop: Colors.redAccent,
                        textCategory: "Power Stats",
                        widgetCategory: PowerStats(
                          heroItem: widget.item,
                        ),
                      )),
                  const SizedBox(height: 5),
                  FadeInLeft(
                    duration:
                        const Duration(milliseconds: kDurationDetails + 400),
                    child: CardCategoryInfo(
                      widget: widget,
                      colorContainerTop: Colors.yellowAccent,
                      textCategory: "Connections",
                      widgetCategory: Connections(
                        heroItem: widget.item,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: 20,
            child: FadeInLeft(
              duration: const Duration(milliseconds: kDurationDetails),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 7),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 7,
                          blurRadius: 7,
                          offset:
                              const Offset(2, 3), // changes position of shadow
                        )
                      ],
                      color: kSearchColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: const Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: size.height * 0.43,
            child: FadeInRight(
              duration: const Duration(milliseconds: kDurationDetails),
              child: widget.item.biography.publisher == 'DC Comics'
                ? Image.asset('lib/assets/images/dc.png')
                : widget.item.biography.publisher == 'Marvel Comics' ? Image.asset('lib/assets/images/marvel.png') : Container(),
            ),)
        ],
      ),
    );
  }
}

class Connections extends StatelessWidget {
  final HeroInfo heroItem;

  const Connections({Key? key, required this.heroItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Team Affiliation".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.connections.groupAffiliation,
            style: textStyleSubtitle,
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Relatives".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.connections.relatives
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            style: textStyleSubtitle,
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class Biography extends StatelessWidget {
  final HeroInfo heroItem;

  const Biography({
    Key? key,
    required this.heroItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Alter Ego(s)".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.biography.alterEgos,
            style: textStyleSubtitle,
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Aliases".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.biography.aliases
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            style: textStyleSubtitle,
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Place of birth".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.biography.placeOfBirth != '-'
                ? heroItem.biography.placeOfBirth
                : 'N/A',
            style: textStyleSubtitle,
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "First Appearance".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.biography.firstAppearance,
            style: textStyleSubtitle,
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Creator".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.biography.publisher,
            style: textStyleSubtitle,
          ),
        ),
      ],
    );
  }
}

class Appearance extends StatelessWidget {
  final HeroInfo heroItem;

  const Appearance({
    Key? key,
    required this.heroItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Gender".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.appearance.gender,
            style: textStyleSubtitle,
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Race".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.appearance.race
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            style: textStyleSubtitle,
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Height".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.appearance.height
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            style: textStyleSubtitle,
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Weight".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.appearance.weight
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            style: textStyleSubtitle,
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Eye Color".toUpperCase(),
              style: textStyleListTile,
            ),
          ),
          subtitle: Text(
            heroItem.appearance.eyeColor,
            style: textStyleSubtitle,
          ),
        ),
      ],
    );
  }
}

class Work extends StatelessWidget {
  final HeroInfo heroItem;

  const Work({Key? key, required this.heroItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          "Base".toUpperCase(),
          style: textStyleListTile,
        ),
      ),
      subtitle: Text(
        heroItem.work.base != '-' ? heroItem.work.base : "N/A",
        style: textStyleSubtitle,
      ),
    );
  }
}

class PowerStats extends StatelessWidget {
  final HeroInfo heroItem;

  const PowerStats({Key? key, required this.heroItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${"Intelligence".toUpperCase()} - ${heroItem.powerstats.intelligence}%",style: textStyleSubtitle,
          ),
        ),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 15.0,
          animationDuration: 5000,
          percent: heroItem.powerstats.intelligence.toDouble() / 100.0,
          barRadius: const Radius.circular(10),
          progressColor: Colors.blue,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${"Strength".toUpperCase()} - ${heroItem.powerstats.strength}%", style: textStyleSubtitle,
          ),
        ),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 15.0,
          animationDuration: 5000,
          percent: heroItem.powerstats.strength.toDouble() / 100.0,
          barRadius: const Radius.circular(10),
          progressColor: Colors.orange,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${"Speed".toUpperCase()} - ${heroItem.powerstats.speed}%", style: textStyleSubtitle,
          ),
        ),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 15.0,
          animationDuration: 5000,
          percent: heroItem.powerstats.speed.toDouble() / 100.0,
          barRadius: const Radius.circular(10),
          progressColor: Colors.green,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${"Durability".toUpperCase()} - ${heroItem.powerstats.durability}%", style: textStyleSubtitle,
          ),
        ),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 15.0,
          animationDuration: 5000,
          percent: heroItem.powerstats.durability.toDouble() / 100.0,
          barRadius: const Radius.circular(10),
          progressColor: Colors.orangeAccent,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${"Power".toUpperCase()} - ${heroItem.powerstats.power}%", style: textStyleSubtitle,
          ),
        ),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 15.0,
          animationDuration: 5000,
          percent: heroItem.powerstats.power.toDouble() / 100.0,
          barRadius: const Radius.circular(10),
          progressColor: Colors.red,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${"Combat".toUpperCase()} - ${heroItem.powerstats.combat}%",style: textStyleSubtitle,
          ),
        ),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 15.0,
          animationDuration: 5000,
          percent: heroItem.powerstats.combat.toDouble() / 100.0,
          progressColor: Colors.black,
          barRadius: const Radius.circular(10),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
