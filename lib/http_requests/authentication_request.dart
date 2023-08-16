import 'dart:convert';

import 'package:design_task/http_requests/request_helper.dart';
import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../main.dart';
import '../screens/landing/landing_page.dart';
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
      userData = response['data']['user'];

      Navigator.pushNamedAndRemoveUntil(
        MyApp.navigatorKey.currentContext!,
        LandingPage.routeName,
        (route) => false,
      );
    } else {
      dynamic result = response['data']['message'];
      String message = result is String
          ? result
          : result is List
              ? (result[0] ?? {})['message'] ?? 'An error occurred'
              : 'An error occurred';
      showCustomDialog(
        message,
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
