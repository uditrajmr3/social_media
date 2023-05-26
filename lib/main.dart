import 'package:social_media/values/app_globals/app_exports.dart';

void main() {
  // setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Social Media",
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.amber,
      ),
      routeInformationParser: ChatRouteInformationParser(),
      routerDelegate: ChatRouteDelegate(),
    );
  }
}
