import 'package:flutter/material.dart';

Container topOptions(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sync overview",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 30)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  foregroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(255, 0, 0, 0)),
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 78, 170, 216),
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.play_arrow),
                label: Text("Sync all")),
            TextButton.icon(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 30)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(08),
                    ),
                  ),
                  foregroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(255, 0, 0, 0)),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 78, 170, 216)),
                ),
                onPressed: () {},
                icon: Icon(Icons.work_history_rounded),
                label: Text("History")),
          ],
        )
      ],
    ),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 181, 203, 214),
        borderRadius: BorderRadius.all(Radius.circular(15))),
  );
}
