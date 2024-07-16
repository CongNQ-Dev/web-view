import 'dart:convert';

import 'package:get/get.dart';

import '../common/entities/customer.dart';
import '../values/storage.dart';
import 'storage.dart';

class CustomerStore extends GetxController {
  static CustomerStore get to => Get.find();
  final _profile = CustomerItem().obs;

  String token = '';
  CustomerItem get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    token = StorageService.to.getString(STORAGE_CUSTOMER_TOKEN_KEY);
    var profileOffline =
        StorageService.to.getString(STORAGE_CUSTOMER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _profile(CustomerItem.fromJson(jsonDecode(profileOffline)));
    }
  }

  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_CUSTOMER_TOKEN_KEY, value);
    token = value;
  }

  Future<String> getProfile() async {
    if (token.isEmpty) return "";
    return StorageService.to.getString(STORAGE_CUSTOMER_PROFILE_KEY);
  }

  Future<void> saveProfile(CustomerItem profile) async {
    StorageService.to
        .setString(STORAGE_CUSTOMER_PROFILE_KEY, jsonEncode(profile));
    _profile(profile);
    setToken(profile.access_token!);
  }

  Future<void> clearStorage() async {
    await StorageService.to.remove(STORAGE_CUSTOMER_TOKEN_KEY);
    await StorageService.to.remove(STORAGE_CUSTOMER_PROFILE_KEY);
    token = '';
  }
}
