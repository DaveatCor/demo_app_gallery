import 'package:demo_app_gallery/domain/model/image.model.dart';
import 'package:demo_app_gallery/index.dart';

class ImageDetail extends StatelessWidget {

  final ImageModel? imageModel;

  const ImageDetail({super.key, required this.imageModel});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("(${imageModel!.id}) ${imageModel!.author}"),
      ),
      body: Column(
        children: [

          SizedBox(
            height: 300,
            child: Card(
              child: ValueListenableBuilder(
                valueListenable: imageModel!.isSaved!, 
                builder: (context, isSaved, wg){

                  if (isSaved == false) return const Center(child: CircularProgressIndicator());

                  return Image.file(File(imageModel!.downloadUrl!));
                  
                }
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
