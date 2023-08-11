import 'package:flutter/material.dart';
import '../../controller/google_drive_controller/google_drive.dart';
import '../../data/color_scheme.dart' as color_scheme;

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  List<String> filters = ['All', 'Used in sync', 'Not used in sync'];
  String selectedFilter = 'All';
  final MyHomePage myHomePage = MyHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: color_scheme.secondaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Column(
                  children: [Text('Seect Account Type'), Divider()],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      // await myHomePage.loginWithGoogle();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return MyHomePage();
                        },
                      ));
                    },
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100,
                            ),
                            child: Image.asset("assets/google_drive.png")),
                        SizedBox(width: 20),
                        Text('Google Drive'),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
        label: Row(
          children: [
            Icon(Icons.add),
            SizedBox(width: 8.0),
            Text('Add account'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 48.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: FilterChip(
                      label: Text(filters[index]),
                      labelStyle: TextStyle(color: Colors.black),
                      backgroundColor: selectedFilter == filters[index]
                          ? color_scheme.mainColor
                          : Colors.transparent,
                      selected: selectedFilter == filters[index],
                      onSelected: (value) {
                        setState(() {
                          selectedFilter = value ? filters[index] : 'All';
                        });
                      },
                      selectedColor: color_scheme.mainColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text('Selected Filter: $selectedFilter'),
          ],
        ),
      ),
    );
  }
}

// void _showDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Column(
//           children: [Text('Seect Account Type'), Divider()],
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () async {
//               await ;
//             },
//             child: Row(
//               children: [
//                 Container(
//                     padding: EdgeInsets.all(5),
//                     height: 35,
//                     width: 35,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.grey.shade100,
//                     ),
//                     child: Image.asset("assets/google_drive.png")),
//                 SizedBox(width: 20),
//                 Text('Google Drive'),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
