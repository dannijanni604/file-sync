import 'package:flutter/material.dart';
import '../../providers/google_drive_provider/google_drive.dart';
import '../../data/color_scheme.dart' as color_scheme;
import '../add account/add_account_screen.dart';

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
                  children: [Text('Select Account Type'), Divider()],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AddAccountScreen();
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
