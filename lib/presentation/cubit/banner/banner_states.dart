abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerVisible extends BannerState {
  final String text;
  BannerVisible(this.text);
}

class BannerHidden extends BannerState {}