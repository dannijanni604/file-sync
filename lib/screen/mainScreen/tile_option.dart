import 'package:flutter/material.dart';

Container tileOptions(BuildContext context, icon, title) {
  return Container(
    height: MediaQuery.of(context).size.height * .1,
    width: MediaQuery.of(context).size.width * .45,
    padding: EdgeInsets.symmetric(vertical: 6),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Color.fromRGBO(211, 167, 255, 1),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Expanded(
        child: Text(
          title,
          style: TextStyle(fontSize: 13),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    ),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 181, 203, 214),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}
