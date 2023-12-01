import 'dart:io';

import 'package:demo_app_gallery/data/rest_api/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileManangement {

  static String? _dir;

  static File? _file;

  static String? fileName;
  
  FileManangement._privateConstructor();

  static Future<void> initState() async {

    await _requestStoragePermission();
    _file = File('$_dir/images/');

    await Directory(_file!.path).create(recursive: true);// _file!.create(recursive: true);

  }

  static Future<void> _requestStoragePermission() async {
    await Permission.storage.request().then((pm) async {
      _dir = (await getApplicationDocumentsDirectory()).path;
    });
  }

  /// Download And Write Image To Storage
  static Future<String?> writeAsBytes(String urlImage, String id) async {

    return await GetApi.getApi.downloadUrlImg(urlImage).then((res) async {

      if (_dir == null){
        await _requestStoragePermission();
      }

      fileName = "${_file!.path}$id.jpg";

      await File(fileName!).writeAsBytes(res.bodyBytes);

      return fileName;

    });
  }
}