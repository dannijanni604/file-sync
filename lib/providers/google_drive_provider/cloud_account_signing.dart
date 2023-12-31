import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis_auth/googleapis_auth.dart';

Future<auth.ServiceAccountCredentials> getServiceAccountCredentials() async {
  ClientId _clientId = auth.ClientId.serviceAccount("106596602295583236212");
  // Load the service account key JSON file
  final auth.ServiceAccountCredentials credentials =
      auth.ServiceAccountCredentials(
    "firebase-adminsdk-db21d@foldersync-72058.iam.gserviceaccount.com",
    _clientId,
    "3dbc16aca4ebddc2510af1547fce5871c674122f",
  );

  return credentials;
}
