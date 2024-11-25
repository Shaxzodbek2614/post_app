import 'dart:convert';

import 'package:http/http.dart' as http;

class Apis {
  Future<List> getAllPosts()async{
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts"); // Url olish
    final response = await http.get(url);  // responseni o'qib olish

    return jsonDecode(response.body);
  }

  Future<List> getAllComments({required int postId}) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/${postId}/comments"); // Url olish
    final response = await http.get(url);  // responseni o'qib olish
    return jsonDecode(response.body);
  }
}