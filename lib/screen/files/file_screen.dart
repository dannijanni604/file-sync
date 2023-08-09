
import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:file_sync/data/color_scheme.dart' as color_scheme;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FileScreen extends StatelessWidget {

 final FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:  Permission.storage.request(),
      builder: (context,request)=>FileManager(
    controller: controller,
    builder: (context, snapshot) {
    final List<FileSystemEntity> entities = snapshot;
      return ListView.builder(
        itemCount: entities.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color.fromARGB(255, 255, 255, 255),
          elevation: 2.0,
            child: ListTile(
              leading: FileManager.isFile(entities[index])
                  ? Icon(Icons.feed_outlined,color:color_scheme.mainColor)
                  : Icon(Icons.folder,color:color_scheme.secondaryColor,),
              title: Text(FileManager.basename(entities[index])),
              onTap: () {
                if (FileManager.isDirectory(entities[index])) {
                    controller.openDirectory(entities[index]);   // open directory
                  } else {
                      // Perform file-related tasks.
                  }
              },
            ),
          );
        },
      );
  },
) ,
    );
  }
}