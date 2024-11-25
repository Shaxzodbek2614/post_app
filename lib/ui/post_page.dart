import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_app/data/apis.dart';

import 'comments_page.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List myPosts = [];
  var isLoading = false;
  final Apis _apis = Apis();

  void _getAllPosts() async {
    setState(() {
      isLoading = true;
    });

    myPosts = await _apis.getAllPosts();

    setState(() {
      isLoading = false;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Post App")),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: isLoading? const Center(
        child: CircularProgressIndicator(),
      )
          :ListView.builder(
          itemCount: myPosts.length,
          itemBuilder: (context,index){
            final post = myPosts[index];

            final String title = post['title'];
            final String body = post['body'];
            final int userId = post['userId'];
            final int postId = post['id'];
            return ExpansionTile(
              title: Text(
                maxLines: 1,
                title,style: TextStyle(
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis
              ),),
              subtitle: Text("userId $userId| postId $postId",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                ),),
              expandedAlignment: Alignment.topLeft,
              childrenPadding: EdgeInsets.all(14),
              children: [
                Text(body,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>CommentsPage(postId: postId,)));
                },
                    child: Text("Comments",))
              ],
            );
          }),
    );
  }
}
