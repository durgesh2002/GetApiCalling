import 'dart:convert';
import 'package:apipracapp/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

List<Photos> photoList = [];
  Future<List<Photos>> getPhoto() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map i in data) {
        Photos pics = Photos(title: i['title'], url: i['url'], id: i['id']);
        photoList.add(pics);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Second Screen"),
        backgroundColor: Colors.blue[300],
           actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ThirdScreen()));
        }, icon: const Icon(Icons.pages))],
      ),
      body: FutureBuilder<List<Photos>>(
        future: getPhoto(),
        builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }  else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(photoList[index].url),
                    ),
                    title: Text(photoList[index].id.toString()),
                    subtitle: Text(photoList[index].title),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;

      Photos({required this.title, required this.url, required this.id});
}
