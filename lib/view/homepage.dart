import 'dart:convert';
import 'package:flutter/material.dart';
import '../Model/postModel.dart';
import 'package:http/http.dart' as http;




class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

// api me arry a raha hai is array ka name nhi hai ia liye data ko pahle is list me dale ge fir show kare ge 
// agar data array me a raha hai lekin array ka  name hai to side data show kar sakte hai list me dal ne ki koy jarurat nhi hai
List<postModel> postList =[];

//call Api
Future<List<postModel>> getPostsApi()async{
final responce = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
var data = jsonDecode(responce.body.toString());
  if(responce.statusCode == 200){
      for(Map i in data){
        postList.add(postModel.fromJson(Map<String, dynamic>.from(i)));
      }
      return postList;
  }else{
      return postList;
  }
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("api basic and array"),

      ),

      body: Column(children: [
          Expanded(
            child: FutureBuilder(
                future: getPostsApi(),
                builder: (context, snapshot){
              if(!snapshot.hasData){
                return Text("loading");
              }else{
                return ListView.builder(
                  itemCount: postList.length,
                    itemBuilder: (context ,index){
                      return Card(
                         color: Colors.orange.shade200,
                        child: Column(

                          children: [
                           rowReuse(title: "title", value:postList[index].title.toString() ),
                           rowReuse(title: "body", value:postList[index].body.toString() ),
                           rowReuse(title: "userId", value:postList[index].userId.toString() ),
                           rowReuse(title: "id", value:postList[index].id.toString() ),

                      ],
                    ),
                  );
                });
              }
            }),
          )
      ],),
    );
  }
}
class rowReuse extends StatelessWidget {
  String title;
  String value;
  rowReuse({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,


        children: [
          Text(title,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
          SizedBox(width: 5,),
          Wrap(children:[ Container(
              width:MediaQuery.of(context).size.width * 0.8,
              child: Text(value))]),
        ],
      ),
    );
  }
}
