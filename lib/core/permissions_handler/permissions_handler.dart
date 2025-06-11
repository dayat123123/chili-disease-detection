import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler {
  static Future<void> requestCameraAndStoragePermission() async {
    Future<bool> requestPermissions() async {
      final cameraStatus = await Permission.camera.request();
      final storageStatus = await Permission.storage.request();

      if (cameraStatus.isGranted && storageStatus.isGranted) {
        print("✅ Semua permission diberikan.");
        return true;
      }

      if (cameraStatus.isPermanentlyDenied ||
          storageStatus.isPermanentlyDenied) {
        print("❌ Permission ditolak permanen. Buka settings.");
        await openAppSettings();
        return false;
      }

      if (cameraStatus.isDenied || storageStatus.isDenied) {
        print("❌ Permission ditolak, coba request ulang sekali lagi.");
        return false;
      }

      if (cameraStatus.isRestricted || storageStatus.isRestricted) {
        print("❌ Permission dibatasi oleh sistem.");
        return false;
      }

      print("❌ Permission tidak diberikan.");
      return false;
    }

    bool granted = await requestPermissions();

    if (!granted) {
      granted = await requestPermissions();

      if (!granted) {
        print("❌ Permission tetap ditolak setelah percobaan kedua.");
      }
    }
  }
}
