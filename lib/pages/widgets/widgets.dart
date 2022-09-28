import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';
import '../../superhero_api/hero_model.dart';
import '../details_page/details_page.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    Key? key,
    required this.item,
    required this.index,
    this.animation = 1,
  }) : super(key: key);

  final HeroInfo item;
  final int index;
  final double animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: 30 * animation,
              top: 150 * animation,
              right: 30 * animation),
          margin: EdgeInsets.fromLTRB(
              kPaddingSideCard * animation,
              280 * animation,
              kPaddingSideCard * animation,
              kPaddingSideCard * animation),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              gradient: linearGradient,
              boxShadow: [
                kShadowContainer,
              ],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30 * animation),
                  bottomRight: Radius.circular(30 * animation),
                  topLeft: Radius.circular(60 * animation),
                  topRight: Radius.circular(210 * animation))),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  item.name,
                  style: TextStyle(fontSize: 50, color: kSearchColor),
                  minFontSize: 40,
                  stepGranularity: 1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 36),
                    children: <InlineSpan>[
                      TextSpan(
                          text: 'Aliases ',
                          style: TextStyle(fontSize: 35, color: kSearchColor)),
                      TextSpan(
                          text: item.biography.aliases[0] != '-'
                              ? '\n${item.biography.aliases.toString().replaceAll("[", "").replaceAll("]", "")}'
                              : '\nN/A',
                          style: TextStyle(
                              fontSize: 20,
                              color: kSearchColor,
                              fontStyle: FontStyle.italic)),
                      const WidgetSpan(
                          alignment: PlaceholderAlignment.bottom,
                          child: SizedBox(height: 35)),
                      TextSpan(
                          text: '\nUniverse',
                          style: TextStyle(fontSize: 28, color: kSearchColor)),
                      const WidgetSpan(
                          alignment: PlaceholderAlignment.bottom,
                          child: SizedBox(height: 70)),
                    ],
                  ),
                ),
                item.biography.publisher == 'DC Comics'
                    ? Image.asset('lib/assets/images/dc.png')
                    : item.biography.publisher == 'Marvel Comics'
                        ? Image.asset('lib/assets/images/marvel.png')
                        : Container(padding: EdgeInsets.only(top: 10, left: 25), height: 70,child: Image.asset('lib/assets/images/unknow.png', color: Colors.white,)),

              ],
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.7, -0.40),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: HeroDetailsPage(item: item),
                    inheritTheme: true,
                    ctx: context),
              );
            },
            child: CircleAvatar(
              backgroundColor: kSearchColor,
              radius: kCircularAvatarSize + 10,
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: item.images.lg,
                placeholder: (context, url) => const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: kCircularAvatarSize,
                  backgroundImage:
                      ExactAssetImage('lib/assets/images/loading.gif'),
                ),
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundImage: image,
                  radius: kCircularAvatarSize,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.75, 0.85),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: HeroDetailsPage(item: item),
                      inheritTheme: true,
                      ctx: context),
                );
              },
              icon: const Icon(Icons.arrow_forward_ios,
                  color: Colors.white, size: 30)),
        )
      ],
    );
  }
}
