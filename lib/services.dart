import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_example/models/image_model.dart';
import 'package:test_example/models/profile_model.dart';

abstract class IServices {
  Future<dynamic> getImageData();
  Future<dynamic> getProfileData();
}

class Services implements IServices {
  @override
  Future getImageData() async {
    var response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      ImageModel imageta = ImageModel.fromJson(jsonDecode(response.body));
      return imageta;
    }
  }

  @override
  Future getProfileData() async {
    var response = await http.get(Uri.parse('https://randomuser.me/api/'));
    if (response.statusCode == 200) {
      ProfileModel data = ProfileModel.fromJson(jsonDecode(response.body));
      return data;
    }
  }
}
