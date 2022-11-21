import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Application',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Movie App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
 }

 class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();
  String movie = "";
  var desc ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
       ),
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 161, 211, 236),
          margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
          child: Column(children: [
           const Text("Enter Movie",
            style: TextStyle(fontSize: 24,
            fontWeight: FontWeight.w500)),
            
           TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Search movie',
            hintText: 'Search movie here',
            ),
              onChanged: (text) {
            setState(() {
              movie = text;
            });
        },
          ),
          ElevatedButton(
            onPressed: _searchMovie, child: const Text("Search")
            ),
          Text(desc,
          // ignore: prefer_const_constructors
            style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.w400)
           )
           ]),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
                  );
                  }

      Future<void> _searchMovie() async {
        var apikey="ef4fa29e";
        var url = Uri.parse('https://www.omdbapi.com/?t=$movie&apikey=$apikey');
        var response = await http.get(url);
        var rescode = response.statusCode;
       if (rescode == 200 && movie.isNotEmpty){
         var jsonData =response.body;
         var parsedJson = json.decode(jsonData);
      setState(() {
        var title = parsedJson["Title"];
        var year = parsedJson["Year"];
        var genre = parsedJson["Genre"];
        var image = parsedJson ["Poster"];
        desc = "Search result for $movie is $title \n\nThis movie genre is $genre and its released in $year.\n\n$image \n";
      }
       );
      } else{
      setState(() {
        desc = "No Record";
      }  
        );
    }

  }
}
