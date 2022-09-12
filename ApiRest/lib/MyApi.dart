import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApi extends StatefulWidget {
  MyApi({Key? key}) : super(key: key);

  @override
  _MyApiState createState() => _MyApiState();
}

class _MyApiState extends State<MyApi> {
  @override
  void initState() {
//response = fetchUsers();
    super.initState();
  }

  Future<List<dynamic>> fetchUsers() async {
    var result = await http
        .get(Uri.parse("https://gorest.co.in/public/v2/users?page=1"));
    return jsonDecode(result.body);
  }

  myApiWidget() {
    return FutureBuilder(
      future: fetchUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              String url = snapshot.data[index]['gender'];
              String status = snapshot.data[index]['status'];
              return Card(
                child: Column(
                  children: [
                    if (url == 'female') ...[
                      ListTile(
                        title: Text(snapshot.data[index]['name']),
                        trailing: Column(
                          children: [
                            if (status == 'inactive') ...[
                              Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              )
                            ] else ...[
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              )
                            ]
                          ],
                        ),
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://thumbs.dreamstime.com/z/icono-del-avatar-de-la-mujer-joven-estilo-simple-83525882.jpg',
                          ),
                        ),
                        subtitle: Text(snapshot.data[index]['email']),
                      )
                    ] else ...[
                      ListTile(
                        title: Text(snapshot.data[index]['name']),
                        trailing: Column(
                          children: [
                            if (status == 'inactive') ...[
                              Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              )
                            ] else ...[
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              )
                            ]
                          ],
                        ),
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://thumbs.dreamstime.com/z/icono-del-hombre-de-avatar-dise%C3%B1o-de-los-empresarios-gr%C3%A1fico-de-vector-73570702.jpg',
                          ),
                        ),
                        subtitle: Text(snapshot.data[index]['email']),
                      )
                    ]
                  ],
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geeks for Geeks"),
      ),
      body: myApiWidget(),
    );
  }
}
