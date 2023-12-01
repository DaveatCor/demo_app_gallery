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
      appBar: AppBar(
        title: Text("(${imageModel!.id}) ${imageModel!.author}"),
      ),
      body: Consumer<ConnectivityProvider>(
        builder: (context, provider, wg){
          return Column(
            children: [

              SizedBox(
                height: 300,
                child: Card(
                  child: Consumer<ConnectivityProvider>(
                    builder: (context, provider, wg){
                      
                      if (provider.connectivityResult!.index == 4){
                        return const Center(child: CircularProgressIndicator(),);
                      }

                      return Image.network(imageModel!.downloadUrl!);
                      
                    },
                  )
                ),
              ),
              
              Row(
                children: [

                  Expanded(child: Contents(title: "Id", subTitle: imageModel!.id,)),

                  Expanded(child: Contents(title: "Author", subTitle: imageModel!.author,))
                  
                ],
              ),
              
            ],
          );
        }
      ),
    );
  }

}

class Contents extends StatelessWidget {
  
  final String? title;
  final String? subTitle;

  const Contents({super.key, @required this.title, @required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(title!, style: const TextStyle(color: Colors.grey),),

        Text(subTitle!)
      ],
    );
  }

}
