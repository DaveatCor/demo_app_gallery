import 'package:demo_app_gallery/domain/model/image.model.dart';
import 'package:demo_app_gallery/index.dart';
import 'package:demo_app_gallery/presentation/provider/connectivity.pro.dart';
import 'package:provider/provider.dart';

class ImageDetail extends StatelessWidget {

  final ImageModel? imageModel;

  const ImageDetail({super.key, required this.imageModel});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Consumer<ConnectivityProvider>(
        builder: (context, provider, wg){
          return Column(
            children: [
              
              Text(imageModel!.author!),
    
              Text(provider.connectivityResult!.index.toString()),
              
            ],
          );
        }
      ),
    );
  }


}