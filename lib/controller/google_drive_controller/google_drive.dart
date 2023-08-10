import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class GoogleClient extends http.BaseClient {
  final http.Client _httpClient = http.Client();
  final Map<String, String> defaultHeaders;
  GoogleClient(this.defaultHeaders);
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(defaultHeaders);
    return _httpClient.send(request);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);
  final String title = "Title";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage = FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn(
  //   scopes: ['https://www.googleapis.com/auth/drive.appdata'],
  // );
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [ga.DriveApi.driveAppdataScope],
  );
  late GoogleSignInAccount googleSignInAccount;
  late ga.FileList list;
  var signedIn = false;

  Future<void> _loginWithGoogle() async {
    GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account != null) {
      googleSignInAccount = account;
      _afterGoogleLogin(account);
    }
  }

  Future<void> _afterGoogleLogin(GoogleSignInAccount gSA) async {
    googleSignInAccount = gSA;
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? user = authResult.user;
    if (user == null) {
      return;
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    storage.write(key: "signedIn", value: "true").then((value) {
      setState(() {
        signedIn = true;
      });
    });
  }

  void _logoutFromGoogle() async {
    googleSignIn.signOut().then((value) {
      print("User Sign Out");
      storage.write(key: "signedIn", value: "false").then((value) {
        setState(() {
          signedIn = false;
        });
      });
    });
  }

  Future<void> _uploadLocalFiles() async {
    final localFolder = await getExternalStorageDirectory();
    final client = GoogleClient(await googleSignInAccount.authHeaders);
    final drive = ga.DriveApi(client);

    if (localFolder != null) {
      final localFiles = await _listLocalFiles(localFolder.path);
      for (final localFile in localFiles) {
        await _uploadFile(drive, localFile);
      }

      print('Local files uploaded to Google Drive.');
    }
  }

  Future<List<File>> _listLocalFiles(String folderPath) async {
    final localDirectory = Directory(folderPath);
    final localFiles =
        await localDirectory.list().where((entity) => entity is File).toList();
    return localFiles.cast<File>();
  }

  Future<void> _uploadFile(ga.DriveApi drive, File localFile) async {
    final fileToUpload = ga.File();
    final fileName = path.basename(localFile.path);

    fileToUpload.parents = ["appDataFolder"];
    fileToUpload.name = fileName;

    final media = ga.Media(localFile.openRead(), localFile.lengthSync());

    try {
      final response =
          await drive.files.create(fileToUpload, uploadMedia: media);
      print('File uploaded: ${response.name}');
    } catch (error) {
      print('Upload File Error: $error');
    }
  }

  Future<void> _listGoogleDriveFiles() async {
    var client = GoogleClient(await googleSignInAccount.authHeaders);
    var drive = ga.DriveApi(client);
    drive.files.list(spaces: 'appDataFolder').then((value) {
      setState(() {
        list = value;
      });
      if (list.files == null) {
        return;
      }
      for (var i = 0; i < list.files!.length; i++) {
        print("Id: ${list.files![i].id} File Name:${list.files![i].name}");
      }
    });
  }

  Future<void> _downloadFile(ga.File file) async {
    final client = GoogleClient(await googleSignInAccount.authHeaders);
    final drive = ga.DriveApi(client);

    try {
      final fileResponse = await drive.files.get(file.id!,
          downloadOptions: ga.DownloadOptions.fullMedia) as ga.Media;

      final directory = await getExternalStorageDirectory();
      final filePath = path.join(directory!.path, file.name!);
      final saveFile = File(filePath);

      final List<int> dataStore = [];
      await for (final data in fileResponse.stream) {
        dataStore.addAll(data);
      }

      await saveFile.writeAsBytes(dataStore);
      print('File saved at ${saveFile.path}');
    } catch (error) {
      print('Download File Error: $error');
    }
  }

  List<Widget> generateFilesWidget() {
    List<Widget> listItem = <Widget>[];
    if (list.files == null) {
      return [];
    }
    for (var i = 0; i < list.files!.length; i++) {
      listItem.add(Row(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
            child: Text('${i + 1}'),
          ),
          Expanded(
            child: Text(list.files?[i].name ?? 'No Name'),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(
              child: Text(
                'Download',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (list.files != null) {
                  _downloadFile(list.files![i]);
                }
              },
            ),
          ),
        ],
      ));
    }
    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
