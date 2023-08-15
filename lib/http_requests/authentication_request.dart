import 'dart:convert';

import 'package:design_task/http_requests/request_helper.dart';

import '../shared/custom_dialog.dart';
import '../shared/custom_loader.dart';

class AuthenticationRequest {
  static Future<void> login({
    required String email,
    required String password,
  }) async {
    CustomLoader.showLoader();
    final response = await HttpRequestHelper.makeRequest(
      path: 'user/test/login',
      requestType: RequestType.post,
      body: jsonEncode(
        {'email': email, 'password': password},
      ),
    );
    await Future.delayed(const Duration(seconds: 5));
    await CustomLoader.dismissLoader();
    if (response['status']) {
      // Navigator.pushNamedAndRemoveUntil(
      //   MyApp.navigatorKey.currentContext!,
      //   LandingPage.routeName,
      //   (route) => false,
      // );
    } else {
      showCustomDialog(
        response['data']['message'] ?? 'An error occurred',
        buttonText: 'Close',
      );
    }
  }

  static Future<bool> register({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    CustomLoader.showLoader();
    final response = await HttpRequestHelper.makeRequest(
      path: 'user/test/register',
      requestType: RequestType.post,
      body: jsonEncode(
        {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password,
        },
      ),
    );
    await CustomLoader.dismissLoader();
    if (response['status']) {
      return true;
    } else {
      showCustomDialog(
        response['data']['message'] ?? 'An error occurred',
        buttonText: 'Close',
      );
      return false;
    }
  }
}
