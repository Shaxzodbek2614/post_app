
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/apis.dart';

class CommentsPage extends StatefulWidget{
  @override
  final int postId;
  const CommentsPage({required this.postId});
  State<StatefulWidget> createState() => CommentsStatePage();

}

class CommentsStatePage extends State<CommentsPage> {
  List comments = [];
  var isLoading = false;
  final Apis _apis = Apis();

  void _getAllPosts() async {
    setState(() {
      isLoading = true;
    });

    comments = await _apis.getAllComments(postId: widget.postId);

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
        title: Center(child: Text("Comments page")),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: isLoading ? const Center(
        child: CircularProgressIndicator(),
      )
          :ListView.builder(
          itemCount:comments.length,
          itemBuilder: (context,index){
            final comment = comments[index];

            final name = comment['name'];
            final email = comment['email'];
            final body = comment['body'];
            return ExpansionTile(
              title: Text(
                maxLines: 1,
                name,style: TextStyle(
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis
              ),),
              subtitle: Text(email,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                ),),
              expandedAlignment: Alignment.topLeft,
              childrenPadding: EdgeInsets.all(14),
              children: [
                Text(body,),
              ],
            );
          }),
    );
  }
}
