import 'package:flutter/material.dart';

Container topOptions(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sync overview",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 0, 0, 0),
                    backgroundColor: Color.fromARGB(255, 78, 170, 216),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.play_arrow),
                  label: Text("Sync all")),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 0, 0, 0),
                    backgroundColor: Color.fromARGB(255, 78, 170, 216),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.work_history_rounded),
                  label: Text("History")),
            ),
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
