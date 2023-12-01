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
  static Future<File?> writeAsBytes(String urlImage, String id) async {

    try {
      print("writeAsBytes");
      await GetApi.getApi.downloadUrlImg(urlImage).then((res) async {
        
        print("res ${res.body}");

        if (_dir == null){
          await _requestStoragePermission();
        }

        fileName = "${_file!.path}$id";
        
        print ("Finish create directory");

        _file = await File("${fileName!}.jpg").writeAsBytes(res.bodyBytes);

        print(_file!.path);

        print("fileName $fileName.jpg");

        print(await Directory("${fileName!}.jpg").exists());

        return _file;

      });
    
    } catch (e) {
      print("Error $e");
    }
    return null;
  }
}