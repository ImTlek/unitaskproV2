import 'state.dart';
import 'package:unitaskpro/constant/app.key.dart';
import 'package:unitaskpro/services/service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MydayBackgroundProvider extends AsyncNotifier<BackgroundModel> {
  Future<BackgroundModel> init() async {
    try {
      //load background
      var serviceInterface = ref.read(storageServiceProvider);
      var readValue = serviceInterface.readValue(AppKey.myDayBcKey);
      var map = Map<String, dynamic>.from(readValue);
      var backgroundModel = BackgroundModel.fromMap(map);

      return backgroundModel;
    } catch (e) {
      return BackgroundModel.defoult();
    }
  }

  void setBackground(BackgroundModel bc) async {
    if (state.requireValue != bc) {
      ref
          .read(storageServiceProvider)
          .writeValue(key: AppKey.myDayBcKey, data: bc.toMap());
      state = AsyncData(bc);
    }
  }

  void setBcType(bool isImage) async {
    update((_) =>
        state.requireValue.copyWith(isColor: !isImage, isImage: isImage));
  }

  @override
  build() async {
    var model = await init();
    return model;
  }
}

final bcProvider =
    AsyncNotifierProvider<MydayBackgroundProvider, BackgroundModel>(
        () => MydayBackgroundProvider());
