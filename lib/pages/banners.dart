import 'package:banner_carousel/banner_carousel.dart';

class BannerImages {
  static const String banner1 = "assets/trip.jpg";
  static const String banner2 = "assets/stop.jpg";
  static const String banner3 = "assets/fare.png";
  static List<BannerModel> listBanners = [
    BannerModel(
      imagePath: banner1,
      id: "1",
    ),
    BannerModel(imagePath: banner2, id: "2"),
    BannerModel(imagePath: banner3, id: "3"),
  ];
}
