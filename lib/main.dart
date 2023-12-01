import 'package:demo_app_gallery/infratstucture/file_management.dart';
import 'package:demo_app_gallery/presentation/provider/connectivity.pro.dart';

import 'package:demo_app_gallery/index.dart';

void main() async {
  
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    Provider.of<ConnectivityProvider>(context, listen: false).initState();
    
    FileManangement.initState();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen()
    );
  }
}