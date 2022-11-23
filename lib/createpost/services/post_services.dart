import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newst4/createpost/model/post_model.dart';
import 'package:newst4/home/screens/home_layout.dart';

class PostServices {
  final dio = Dio();

  sendPost(PostModel model, BuildContext context) async {
    try {
      final response = await dio.post(
          "https://303292b3-af7a-40a5-87b5-7ca0524741e0.mock.pstmn.io/posts",
          data: model.toJson()
          //     data: {
          // "title": "<string>",
          // "kind": "<string>",
          // "text": "<string>",
          // "url": "<string>",
          // "owner": "<string>",
          // "ownerType": "<string>",
          // "nsfw": "<boolean>",
          // "spoiler": "<boolean>",
          // "sendReplies": "<boolean>",
          // "flairId": "<string>",
          // "flairText": "<string>",
          // "suggestedSort": "<string>",
          // "scheduled": "<boolean>",
          // "sharedFrom": "<string>"
          // }
          );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("تم الارسال", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green),
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => homeLayoutScreen()));
      }
    } catch (e) {}
  }
}
