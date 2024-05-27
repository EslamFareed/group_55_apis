// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Map> posts = [];
//   Dio dio = Dio();

//   _getPosts() async {
//     var response = await dio.get("https://jsonplaceholder.typicode.com/posts");

//     if (response.statusCode == 200) {
//       var data = response.data as List;
//       for (var element in data) {
//         posts.add(element);
//       }

//       setState(() {});
//     } else {
//       print("Error");
//     }
//   }

//   @override
//   void initState() {
//     _getPosts();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           dio.post(
//             "LINK",
//             queryParameters: {"email": "eslam"},
//             data: FormData.fromMap({})
//           );
//         },
//       ),
//       appBar: AppBar(
//         title: const Text("Posts"),
//         backgroundColor: Colors.amber,
//         foregroundColor: Colors.white,
//       ),
//       body: ListView.builder(
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.deepOrange,
//                 child: Text("${posts[index]["id"]}"),
//               ),
//               title: Text(posts[index]["title"]),
//               subtitle: Text(posts[index]["body"]),
//             ),
//           );
//         },
//         itemCount: posts.length,
//       ),
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map> posts = [];
  Dio dio = Dio();

  _getPosts() async {
    var response = await dio.get(
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=e3b8fdc5a0154931b38b9162b1ee0aac");

    if (response.statusCode == 200) {
      var data = response.data as Map;
      var list = data["articles"] as List;
      for (var element in list) {
        posts.add(element);
      }

      setState(() {});
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    _getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: 250,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: posts[index]["urlToImage"] == null
                    ? const NetworkImage(
                        "https://ralfvanveen.com/wp-content/uploads/2021/06/Placeholder-_-Glossary.svg")
                    : NetworkImage(
                        posts[index]["urlToImage"],
                      ),
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(5, 5),
                  blurRadius: 8,
                  color: Colors.black38,
                )
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black38,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: Text(
                      posts[index]["author"] ?? "NO Authors",
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width * .8,
                    child: Text(
                      posts[index]["title"] ?? "NO Title",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.sizeOf(context).width * .9,
                    child: Text(
                      posts[index]["description"] ?? "NO Description",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("READ MORE",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: posts.length,
      ),
    );
  }
}
