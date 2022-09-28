import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'details_page.dart';

class DiagonalClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.58);
    path.lineTo(0, size.height * 0.5);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CardCategoryInfo extends StatelessWidget {
  const CardCategoryInfo({
    Key? key,
    required this.widget,
    required this.colorContainerTop,
    required this.textCategory,
    required this.widgetCategory,
  }) : super(key: key);

  final HeroDetailsPage widget;
  final Color colorContainerTop;
  final String textCategory;
  final Widget widgetCategory;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 7,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
              child: Container(
                //margin: EdgeInsets.only(top: 5, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: colorContainerTop,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: false,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: ListTile(
                    dense: true,
                    title: Text(
                      textCategory,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.black54),
                    )),
                collapsed: Container(),
                expanded: widgetCategory,
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
