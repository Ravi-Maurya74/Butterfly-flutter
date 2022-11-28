// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:http/http.dart';
import 'dart:convert';
import 'package:date_format/date_format.dart';

class NetworkHelper {
  static String baseUrl = 'https://ravimaurya.pythonanywhere.com/';
  final String url;
  NetworkHelper({required this.url});
  Future getData() async {
    Response response = await get(Uri.parse(baseUrl + url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future sendData(
      String name, String email, String password, DateTime dob) async {
    String first_name, last_name;
    if (name.indexOf(' ') == -1) {
      first_name = name;
      last_name = '';
    } else {
      first_name = name.substring(0, name.indexOf(' '));
      last_name = name.substring(name.indexOf(' ') + 1);
    }
    Map<String, dynamic> jsonMap = {
      'first_name': first_name,
      'last_name': last_name,
      'user_email': email,
      'password': password,
      'dob': formatDate(dob, [yyyy, '-', mm, '-', dd]),
    };
    String jsonString = json.encode(jsonMap);
    print('before send.');
    final resp = await post(
      Uri.parse(baseUrl + 'api/create/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
    print(resp.statusCode);
    print(resp.body);
    return resp.statusCode;
  }

  Future<List<dynamic>> getHomePagePosts(dynamic following) async {
    Map<String, dynamic> jsonMap = {'following': following};
    print(following);
    String jsonString = json.encode(jsonMap);
    final resp = await post(
      Uri.parse(baseUrl + 'api/homepageposts/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
    print(resp.body);
    return jsonDecode(resp.body);
  }

  Future likePost(int user_id, int post_id) async {
    Map<String, dynamic> jsonMap = {"user_id": user_id, "post_id": post_id};
    String jsonString = jsonEncode(jsonMap);
    final resp = await post(
      Uri.parse(baseUrl + 'api/likepost/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
  }

  Future dislikePost(int user_id, int post_id) async {
    Map<String, dynamic> jsonMap = {"user_id": user_id, "post_id": post_id};
    String jsonString = jsonEncode(jsonMap);
    final resp = await post(
      Uri.parse(baseUrl + 'api/dislikepost/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
  }

  Future createPost(int user_id, String post_content) async {
    Map<String, dynamic> jsonMap = {
      "user_id": user_id,
      "content": post_content
    };
    String jsonString = jsonEncode(jsonMap);
    final resp = await post(
      Uri.parse(baseUrl + 'api/newpost/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
    print(resp.body);
  }

  Future bookmarkPost(int user_id, int post_id) async {
    Map<String, dynamic> jsonMap = {"user_id": user_id, "post_id": post_id};
    String jsonString = jsonEncode(jsonMap);
    final resp = await post(
      Uri.parse(baseUrl + 'api/bookmark/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
  }

  Future unmarkPost(int user_id, int post_id) async {
    Map<String, dynamic> jsonMap = {"user_id": user_id, "post_id": post_id};
    String jsonString = jsonEncode(jsonMap);
    final resp = await post(
      Uri.parse(baseUrl + 'api/unmark/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
  }

  Future followUser(int user_id, int to_follow) async {
    Map<String, dynamic> jsonMap = {"user_id": user_id, "to_follow": to_follow};
    String jsonString = jsonEncode(jsonMap);
    final resp = await post(
      Uri.parse(baseUrl + 'api/addfollower/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
    print('followuser');
  }

  Future unfollowUser(int user_id, int to_unfollow) async {
    Map<String, dynamic> jsonMap = {
      "user_id": user_id,
      "to_unfollow": to_unfollow
    };
    String jsonString = jsonEncode(jsonMap);
    final resp = await post(
      Uri.parse(baseUrl + 'api/removefollower/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
    print('unfollowuser');
  }

  Future deletepost(int id) async {
    Response response = await delete(Uri.parse(baseUrl + 'api/deletepost/$id'));
    print(response.statusCode);
    print(response.body);
  }

  Future searchUser(String name) async {
    Map<String, dynamic> jsonMap = {
      "name": name,
    };
    String jsonString = jsonEncode(jsonMap);
    final resp = await post(
      Uri.parse(baseUrl + 'api/searchuser/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
    print(resp.body);
    return jsonDecode(resp.body);
  }

  Future getReplies(int post_id) async {
    Map<String, dynamic> jsonMap = {
      "post_id": post_id,
    };
    String jsonString = jsonEncode(jsonMap);
    final resp = await post(
      Uri.parse(baseUrl + 'api/getreplies/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
    print(resp.body);
    return jsonDecode(resp.body);
  }

  Future sendReply(int post_id, String content, int replier_id) async {
    Map<String, dynamic> jsonMap = {
      "replied_to": post_id,
      "content": content,
      "user_id": replier_id,
    };
    String jsonString = jsonEncode(jsonMap);
    final resp = await post(
      Uri.parse(baseUrl + 'api/newreply/'),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    );
    print(resp.body);
    return jsonDecode(resp.body);
  }
}
