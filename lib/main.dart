import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:my_mind/app/routes.dart';
import 'app/utils/screen_config.dart';
import 'login_state.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final state = await LoginState.create();
  state.checkLoggedIn();
  runApp(MyApp(loginState: state));
}

class MyApp extends StatelessWidget {
  final LoginState loginState;
  const MyApp({Key? key, required this.loginState}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterCleanArchitecture.debugModeOn();
    return MultiProvider(
      /// 設定狀態與路由 providers
      providers: [
        ChangeNotifierProvider<LoginState>(
          lazy: false,
          create: (_) => loginState,
        ),
        Provider<MyMindRouter>(
            lazy: false, create: (_) => MyMindRouter(loginState))
      ],
      child: Builder(builder: (BuildContext context) {
        final router = Provider.of<MyMindRouter>(context, listen: false).router;

        /// 設定路由
        return MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          debugShowCheckedModeBanner: false,
          title: '買賣',
        );
      }),
    );
  }
}
