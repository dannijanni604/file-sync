import 'package:flutter/material.dart';
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
  bool isLoggingEnabled = false;

  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('Help'),
          subtitle: Row(
            children: [
              TextButton(
                onPressed: () {
                  // Handle Support button press
                },
                child: Text(
                  'Support',
                  style: TextStyle(color: color_scheme.secondaryColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle User Guide button press
                },
                child: Text(
                  'User Guide',
                  style: TextStyle(color: color_scheme.secondaryColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle Help Translate button press
                },
                child: Text(
                  'Help Translate',
                  style: TextStyle(color: color_scheme.secondaryColor),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Debug Logging',
              ),
              Switch(
                value: isLoggingEnabled,
                onChanged: (value) {
                  // Handle enable/disable switch
                  isLoggingEnabled = value;
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

thirdCard(BuildContext context) {
  bool isSyncEnabled = true;
  bool isNotificationsEnabled = false;
  bool isAccessPinEnabled = false;

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
                    value: isSyncEnabled,
                    onChanged: (value) {
                      // Handle sync switch change
                      isSyncEnabled = value;
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
                    children: [  Icon(Icons.notifications),
                      SizedBox(width: 8.0),
                      Switch(
                        activeColor: color_scheme.mainColor,
                        focusColor: color_scheme.mainColor,
                        value: isNotificationsEnabled,
                        onChanged: (value) {
                          // Handle notifications switch change
                          isNotificationsEnabled = value;
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
                  Switch(
                    value: isAccessPinEnabled,
                    onChanged: (value) {
                      // Handle access PIN switch change
                      isAccessPinEnabled = value;
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
                  children: [
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
                  children: [
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
}
