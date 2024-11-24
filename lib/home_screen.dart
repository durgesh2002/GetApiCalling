import 'dart:convert';

import 'package:apipracapp/models/post_model.dart';
import 'package:apipracapp/secon_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
   List<PostModels> postModels = [];

   Future<List<PostModels>>  getApiRequest() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
          var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
          postModels.add(PostModels.fromJson(Map<String, dynamic>.from(i)));
      }
      return postModels;
    } else {
     return postModels;
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title:  Text('API'),
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondScreen()));
        }, icon: Icon(Icons.pages))],
      ),
      body: Column(
        children: [
          FutureBuilder(future: getApiRequest(), builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              return Expanded(
                child: ListView.builder(
                  itemCount: postModels.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text("Id:" , style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w600),),
                              SizedBox(width: 3,),
                                  Text(postModels[index].id.toString()),
                                ],
                              ),
                              SizedBox(height: 5,),
                              const Text("Title:" , style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w600),),
                              Text(postModels[index].title.toString()),
                              SizedBox(height: 5,),
                              const Text("Description:" , style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w600),),
                              Text(postModels[index].body.toString()),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          
          })
        ],
      ),
    );
  }
}