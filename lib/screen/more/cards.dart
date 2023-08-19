import 'package:file_sync/providers/more_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../data/color_scheme.dart' as color_scheme;

Card firstCard() {
  return Card(
    child: Column(
      children: [
        ListTile(
          title: Text('FileSync'),
          subtitle: Row(
            children: [
              Text(
                'Version',
                style: TextStyle(color: color_scheme.secondaryColor),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Licenses',
                style: TextStyle(color: color_scheme.secondaryColor),
              ),
            ],
          ),
          trailing: Image.asset('assets/logo.png'),
          onTap: () {
            // Handle card tap
          },
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  // Handle Privacy Policy button press
                },
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(color: color_scheme.secondaryColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle EuLa button press
                },
                child: Text(
                  'EuLa',
                  style: TextStyle(color: color_scheme.secondaryColor),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

secondCard(BuildContext context) {
  return Consumer<MoreProvider>(builder: (context, value, child) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Help'),
            subtitle: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Handle Support button press
                    },
                    child: Text(
                      'Support',
                      style: TextStyle(color: color_scheme.secondaryColor),
                    ),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 0)),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Handle User Guide button press
                    },
                    child: Text(
                      'User Guide',
                      style: TextStyle(color: color_scheme.secondaryColor),
                    ),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 0)),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Handle Help Translate button press
                    },
                    child: Text(
                      'Help Translate',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: color_scheme.secondaryColor),
                    ),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 0)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Debug Logging',
                ),
                Switch(
                  value: value.isLoggingEnabled,
                  onChanged: (val) {
                    value.toggleToMoreSetting(val, 0);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });
}

thirdCard(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  return Consumer<MoreProvider>(builder: (context, value, chidl) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Configuration'),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Scheduled sync enabled'),
                    Switch(
                      value: value.isSyncEnabled,
                      onChanged: (val) {
                        value.toggleToMoreSetting(val, 1);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Notifications enabled'),
                    Row(
                      children: [
                        Icon(Icons.notifications),
                        SizedBox(width: 8.0),
                        Switch(
                          // activeColor: color_scheme.mainColor,
                          // focusColor: color_scheme.mainColor,
                          value: value.isNotiEnable,
                          onChanged: (val) {
                            value.toggleToMoreSetting(val, 2);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Use access PIN'),
                    Spacer(),
                    value.isAccessPinEnabled
                        ? GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Container(
                                      width: 500,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Icon(
                                                Icons.lock,
                                                size: 25,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "PIN",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller:
                                                      value.pincontroller,
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    label: Text("PIN"),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  validator: (v) {
                                                    if (v!.isNotEmpty &&
                                                        v.length >= 4) {
                                                      return null;
                                                    } else {
                                                      return "pin length must be 4 or above";
                                                    }
                                                  },
                                                ),
                                                SizedBox(height: 10),
                                                TextFormField(
                                                  controller:
                                                      value.pinCcontroller,
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    label: Text("Confirm PIN"),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  validator: (v) {
                                                    if (v!.isNotEmpty &&
                                                        value.pincontroller
                                                                .text ==
                                                            value.pinCcontroller
                                                                .text) {
                                                      {
                                                        return null;
                                                      }
                                                    } else {
                                                      return "same as above pin";
                                                    }
                                                  },
                                                ),
                                                SizedBox(height: 10),
                                                TextFormField(
                                                  controller:
                                                      value.pinExTimecontroller,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    label: Text(
                                                      "Pin Expire In Sec",
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Unlock With Fingerprint",
                                                      style: TextStyle(
                                                          fontSize: 8),
                                                    ),
                                                    Switch(
                                                      value: value.isfpEnable,
                                                      onChanged: (val) {
                                                        // value
                                                        //     .toggleUFPEnabled(
                                                        //         fpEnable:
                                                        //             val);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel")),
                                      TextButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                value.pincontroller.text ==
                                                    value.pinCcontroller.text) {
                                              value.onSavePinSetting();
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text("Save")),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.onetwothree,
                              size: 30,
                              color: Colors.blue,
                            ),
                          )
                        : SizedBox(),
                    SizedBox(width: 5),
                    Switch(
                      value: value.isAccessPinEnabled,
                      onChanged: (val) {
                        value.toggleToMoreSetting(val, 3);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(color_scheme.mainColor),
                    foregroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 48, 48, 48)),
                  ),
                  onPressed: () {
                    // Handle Settings button press
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.settings),
                      SizedBox(width: 8.0),
                      Text('Settings'),
                    ],
                  ),
                ),
                SizedBox(width: 16.0),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(color_scheme.mainColor),
                    foregroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 48, 48, 48)),
                  ),
                  onPressed: () {
                    // Handle Privacy button press
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.privacy_tip),
                      SizedBox(width: 8.0),
                      Text('Permissions'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });
}
