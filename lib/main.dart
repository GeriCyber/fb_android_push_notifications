import 'package:flutter/material.dart';
import 'package:flutter_push_notifications/screens/home_screen.dart';
import 'package:flutter_push_notifications/screens/message_screen.dart';
import 'package:flutter_push_notifications/services/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override

  void initState() {
    super.initState();
    PushNotificationsService.messageStream.listen((message) {
      navigatorKey.currentState?.pushNamed('message', arguments: message);
      final snackbar = SnackBar(content: Text(message));
      scaffoldMessengerKey.currentState?.showSnackBar(snackbar);
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Push Notifications',
      initialRoute: 'home',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      routes: {
        'home': (_) => const HomeScreen(),
        'message': (_) => const MessageScreen()
      },
    );
  }
}