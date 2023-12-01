import 'package:demo_app_gallery/application/services/store_data.s.dart';
import 'package:demo_app_gallery/data/rest_api/get.dart';
import 'package:demo_app_gallery/domain/contant/storage_key.const.dart';
import 'package:demo_app_gallery/domain/model/image.model.dart';
import 'package:demo_app_gallery/domain/usecase/list_image/list_image.dart';
import 'package:demo_app_gallery/infratstucture/file_management.dart';
import 'package:demo_app_gallery/presentation/provider/connectivity.pro.dart';
import 'package:demo_app_gallery/index.dart';

class ListImageImpl implements ListImageI {

  final GetApi _getApi = GetApi.getApi;

  List<ImageModel>? images;

  ValueNotifier<bool> isReady = ValueNotifier(false);
  
  BuildContext? _context;

  set setBuildContext(BuildContext ctx){
    _context = ctx;
  }

  @override
  Future<void> getImages() async {
    
    if (images == null){

      try {

        // Check If Have No Connection
        if ( json.decode( (await SecureStorage.secureStorage.getData(StorageConstant.connectivityResult))! ) == 4){
          await _getImagesFromDb();
        } else {
          await _getImagesFromApi();
        }

        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        Provider.of<ConnectivityProvider>(_context!, listen: false).notifyListeners();

      } catch (e) {
        
        isReady.value = true;
        
        print("Catch error $e");
      }
    }

  }

  Future<void> _getImagesFromApi() async {

    await _getApi.getListImages().then((res) async {

      if (res.statusCode == 200){

        images = List<Map<String, dynamic>>.from(json.decode(res.body)).map((map) {

          return ImageModel.fromJson(map);
          
        }).toList();

        // Notify State
        isReady.value = true;
        
        await downloadNSaveImage();
        
        // Store Data
        SecureStorage.secureStorage.storeData(StorageConstant.listImage, json.encode(images!.map((e) => e.toJson()).toList()));

      }

    });

  }

  Future<void> downloadNSaveImage() async {
    
    for (var img in images!){

      img.downloadUrl = (await FileManangement.writeAsBytes(img.downloadUrl!, img.id!));

      img.isSaved!.value = true;
    }
  
  }

  Future<void> _getImagesFromDb() async {
    
    await SecureStorage.secureStorage.getData(StorageConstant.listImage).then((res) async {
      
      if (res != null){

        images = List<Map<String, dynamic>>.from(json.decode(res)).map((map) {
          return ImageModel.fromJson(map);
        }).toList();

        // Notify State
        isReady.value = true;
      }

    });

  }

}