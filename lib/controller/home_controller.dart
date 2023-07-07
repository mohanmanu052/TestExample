import 'package:flutter/material.dart';
import 'package:test_example/models/image_model.dart';
import 'package:test_example/models/profile_model.dart';
import 'package:test_example/services.dart';

class HomeController extends ChangeNotifier implements IServices {
  Services _networkServices = Services();
  String imageurl = '';
  ProfileModel? profileData;
  @override
  Future getImageData() async {
    ImageModel res = await _networkServices.getImageData();
    imageurl = res.message ?? '';
    print('the imge url was----' + imageurl.toString());
    notifyListeners();
    // TODO: implement getImageData
  }

  @override
  Future<ProfileModel> getProfileData() async {
    profileData = await _networkServices.getProfileData();
    return profileData ?? ProfileModel();
  }

  void onButtonTap() {
    getImageData();
  }
}
