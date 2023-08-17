import 'package:file_sync/providers/google_drive_provider/google_drive_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/app_snackbar.dart';

class AddAccountScreen extends StatelessWidget {
  const AddAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final DriveController driveProvider = Provider.of<DriveController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Drive"),
      ),
      body: Consumer<DriveController>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  // height: MediaQuery.of(context).size.height * 0.27,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                          Text(
                            'Google Drive',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.error),
                          SizedBox(width: 5),
                          Text(
                            "Not used in sync",
                            softWrap: true,
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: const [
                                Icon(Icons.add),
                                Text("Folder Pair"),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 12)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                color: Colors.blueGrey,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                      Icons
                                          .signal_wifi_statusbar_connected_no_internet_4,
                                      color: Colors.white),
                                ),
                              ),
                              Text("Test")
                            ],
                          ),
                          SizedBox(width: 15),
                          Column(
                            children: [
                              Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                color: Colors.redAccent.shade700,
                                child: IconButton(
                                  onPressed: () async {
                                    value.logoutFromGoogle();
                                    appSnackBar(context, "Account Logged Out");
                                  },
                                  icon: Icon(Icons.delete, color: Colors.white),
                                ),
                              ),
                              Text("Delete")
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Container(
                  padding: EdgeInsets.all(25),
                  height: MediaQuery.of(context).size.height / 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300,
                  ),
                  child: value.signedIn
                      ? Container(
                          child: Column(children: [
                            Row(
                              children: [
                                Text("Name"),
                                Text(value.user.displayName.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Quota"),
                                Text(value.quota.toString() + "GB"),
                              ],
                            )
                          ]),
                        )
                      : GestureDetector(
                          onTap: () async {
                            value.loginWithGoogle();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue)),
                                height: 35,
                                width: 35,
                                child: Image.asset("assets/google.png"),
                              ),
                              Container(
                                color: Colors.blue.shade600,
                                height: 35,
                                width: 150,
                                child: Center(
                                  child: Text(
                                    // "Sign in with Google",
                                    "Login with Google",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
