import 'package:equatable/equatable.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object?> get props => [];
}

class BannerInitial extends BannerState {
  const BannerInitial();

  @override
  List<Object?> get props => [];
}

class BannerVisible extends BannerState {
  final String text;
  const BannerVisible(this.text);

  @override
  List<Object?> get props => [text];
}

class BannerHidden extends BannerState {
  const BannerHidden();

  @override
  List<Object?> get props => [];
}
