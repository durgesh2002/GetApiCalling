import 'dart:convert';

import 'package:apipracapp/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithoutModel extends StatefulWidget {
  const WithoutModel({super.key});

  @override
  State<WithoutModel> createState() => _WithoutModelState();
}

class _WithoutModelState extends State<WithoutModel> {
  var data;

  Future  getUserWithoutModel () async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if(response.statusCode==200){
      data = jsonDecode(response.body.toString());
      return data;
    }else{
      return data;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Without Model"),
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        children: [
          FutureBuilder(future: getUserWithoutModel(), builder: (context,AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }
            else{
              return Expanded(
                child: ListView.builder(itemCount: data.length, itemBuilder: (context, index){
                  return Card(
                    child:Column(
                      children: [
                        ReUsableRow(title: 'ID:', value: data[index]['id'].toString()),
                        ReUsableRow(title: 'Geo:', value: data[index]['address']['geo']['lat'].toString()),
                      ],
                    ) ,
                  );
                }),
              );
            }
          }),
        ],
      ),
    );
  }
}