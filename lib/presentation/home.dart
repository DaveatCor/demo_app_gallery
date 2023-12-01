import 'dart:io';

import 'package:demo_app_gallery/application/services/connection.s.dart';
import 'package:demo_app_gallery/domain/usecase/list_image/list_image.impl.dart';
import 'package:demo_app_gallery/index.dart';
import 'package:demo_app_gallery/presentation/image_detail.dart';
import 'package:demo_app_gallery/presentation/provider/connectivity.pro.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  
  HomeScreen({super.key});

  final ListImageImpl _listImageImpl = ListImageImpl();

  @override
  Widget build(BuildContext context) {

    _listImageImpl.setBuildContext = context;

    _listImageImpl.getImages();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Gallery"),
        actions: [

          Consumer<ConnectivityProvider>(
            builder: (context, provider, wg){
              
              if (provider.connectivityResult == null) {return const SizedBox();}

              else if (provider.connectivityResult!.index == 4){
                
                return const Row(
                  children: [

                    SizedBox(height: 20, width: 20, child: CircleAvatar(backgroundColor: Colors.grey,)),

                    Text("Offline")
                  ],
                );
              }
              
              return const Row(
                children: [

                  SizedBox(height: 20, width: 20, child: CircleAvatar(backgroundColor: Colors.green,)),

                  Text("Online")
                ],
              );

            }
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
      
              // Notifer For Data Fetched
              ValueListenableBuilder(
                valueListenable: _listImageImpl.isReady, 
                builder: (context, isReady, wg){
      
                  if (isReady == false) return const CircularProgressIndicator();
      
                  if(_listImageImpl.images!.isEmpty) return const Text("Image not found");
      
                  return ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: _listImageImpl.images!.map((e) {
                      return InkWell(
                        onTap: (){

                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => ImageDetail(imageModel: e,))
                          );
                        },
                        child: SizedBox(
                          height: 300,
                          child: Card(
                            child: ValueListenableBuilder(
                              valueListenable: e.isSaved!, 
                              builder: (context, isSaved, wg){

                                if (isSaved == false) return const Center(child: CircularProgressIndicator());

                                return Image.file(File(e.downloadUrl!));
                                
                              }
                            )

                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              )
      
            ],
          ),
        ),
      )
    );
  }
}
