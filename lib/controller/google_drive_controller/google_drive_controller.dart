import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:googleapis_auth/auth_io.dart';

Future<http.Client> getHttpClient() async {
  //Get Credentials
  var credentials = await storage.getCredentials();
  if (credentials == null) {
    //Needs user authentication
    var authClient =
        await clientViaUserConsent(ClientId(_clientId), _scopes, (url) {
      //Open Url in Browser
      launch(url);
    });
    //Save Credentials
    await storage.saveCredentials(authClient.credentials.accessToken,
        authClient.credentials.refreshToken!);
    return authClient;
  } else {
    print(credentials["expiry"]);
    //Already authenticated
    return authenticatedClient(
        http.Client(),
        AccessCredentials(
            AccessToken(credentials["type"], credentials["data"],
                DateTime.tryParse(credentials["expiry"])!),
            credentials["refreshToken"],
            _scopes));
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
  final storage = new FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =
      GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive.appdata']);
  late GoogleSignInAccount googleSignInAccount;
  late ga.FileList list;
  var signedIn = false;

  Future<void> _loginWithGoogle() async {
    signedIn = await storage.read(key: "signedIn") == "true" ? true : false;
    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? googleSignInAccount) {
      _afterGoogleLogin(googleSignInAccount!);
    });
    if (signedIn) {
      try {
        googleSignIn.signInSilently().whenComplete(() => () {});
      } catch (e) {
        storage.write(key: "signedIn", value: "false").then((value) {
          setState(() {
            signedIn = false;
          });
        });
      }
    } else {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      _afterGoogleLogin(googleSignInAccount!);
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

  _uploadFileToGoogleDrive() async {
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
    var drive = ga.DriveApi(client);
    ga.File fileToUpload = ga.File();
    var file = await FilePicker.getFile();
    fileToUpload.parents = ["appDataFolder"];
    fileToUpload.name = path.basename(file.absolute.path);
    var response = await drive.files.create(
      fileToUpload,
      uploadMedia: ga.Media(file.openRead(), file.lengthSync()),
    );
    print(response);
    _listGoogleDriveFiles();
  }

  Future<void> _listGoogleDriveFiles() async {
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
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

  Future<void> _downloadGoogleDriveFile(String fName, String gdID) async {
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
    var drive = ga.DriveApi(client);
    ga.Media file = await drive.files
        .get(gdID, downloadOptions: ga.DownloadOptions.FullMedia);
    print(file.stream);

    Directory? directory = await getExternalStorageDirectory();
    if (directory == null) {
      return;
    }
    print(directory.path);
    final saveFile = File(
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}$fName');
    List<int> dataStore = [];
    file.stream.listen((data) {
      print("DataReceived: ${data.length}");
      dataStore.insertAll(dataStore.length, data);
    }, onDone: () {
      print("Task Done");
      saveFile.writeAsBytes(dataStore);
      print("File saved at ${saveFile.path}");
    }, onError: (error) {
      print("Some Error");
    });
  }

  List<Widget> generateFilesWidget() {
    List<Widget> listItem = <Widget>[];
    if (list.files == null) {
      return [];
    }
    for (var i = 0; i < list.files!.length; i++) {
      listItem.add(Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.05,
            child: Text('${i + 1}'),
          ),
          Expanded(
            child: Text(list.files?[i].name ?? 'No Name'),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(
              child: Text(
                'Download',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _downloadGoogleDriveFile(
                  list.files?[i].name ?? 'No Name',
                  list.files?[i].id ?? '_01',
                );
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
