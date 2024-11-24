import 'dart:convert';


import 'package:apipracapp/models/user_model.dart';
import 'package:apipracapp/without_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {


 List<UserModel> userList =[];
    Future<List<UserModel>> getUserList ()async {
      final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      if(response.statusCode==200){
         var data = jsonDecode(response.body.toString());
         for (Map i in data) {
           userList.add(UserModel.fromJson(i.cast<String, dynamic>()));
         }
           return userList;
      }else{
        return userList;
      }

    }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Third Screen"),
        backgroundColor: Colors.blue[300],
          
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const WithoutModel()));
            }, 
            icon: Icon(Icons.pages_outlined))
          ],
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Expanded(
                child: FutureBuilder(future: getUserList(), builder: (context, AsyncSnapshot<List<UserModel>> snapshot){
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else {
                
                    return ListView.builder(itemCount:snapshot.data!.length ,itemBuilder: (context, index){
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           ReUsableRow(title: 'ID:', value: snapshot.data![index].id.toString()),
                            ReUsableRow(title: 'Name:', value: snapshot.data![index].name),
                            ReUsableRow(title: 'Email:', value: snapshot.data![index].email),
                            ReUsableRow(title: 'City:', value: snapshot.data![index].address.city),
                            ReUsableRow(title: 'Phone:', value: snapshot.data![index].phone),
                            ReUsableRow(title: 'Latitude:', value: snapshot.data![index].address.geo.lat),
                           
                          ],
                        ),
                      );
                    });
                  }
                }),
              )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ReUsableRow extends StatelessWidget {
  String title;
  String value;
 ReUsableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          SizedBox(width: 20),  // space between column elements
          Text(value),
        ],
      ),
    );
  }
}