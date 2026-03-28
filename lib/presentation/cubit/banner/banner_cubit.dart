import 'package:flutter_bloc/flutter_bloc.dart';

import 'banner_states.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerHidden());
  // التحكم في ظهور البانر بشكل صحيح

  void showBanner(String text) => emit(BannerVisible(text));
  // اخفاء البانر بدون مشاكل
  void hideBanner() => emit(BannerHidden());
}
