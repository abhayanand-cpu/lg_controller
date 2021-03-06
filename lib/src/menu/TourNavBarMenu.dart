import 'package:lg_controller/src/ui/NavBar.dart';

/// Menu items for tour [NavBar].
class TourNavBarMenu {
  final String title;

  const TourNavBarMenu(this.title);

  static values() {
    return [
      RECENTLY_VIEWED,
      PRIVATE_2,
      CATEGORY_6,
      CATEGORY_7,
      CATEGORY_8,
      CATEGORY_9
    ];
  }

  static const TourNavBarMenu RECENTLY_VIEWED = const TourNavBarMenu("Recently_Viewed");
  static const TourNavBarMenu PRIVATE_2 = const TourNavBarMenu("Private");
  static const TourNavBarMenu CATEGORY_6 = const TourNavBarMenu("Category_6");
  static const TourNavBarMenu CATEGORY_7 = const TourNavBarMenu("Category_7");
  static const TourNavBarMenu CATEGORY_8 = const TourNavBarMenu("Category_8");
  static const TourNavBarMenu CATEGORY_9 = const TourNavBarMenu("Category_9");
}
