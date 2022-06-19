import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

//
import 'app/bindings/app_bindings.dart';
import 'app/lang/translate_service.dart';
import 'app/routes/app_routes.dart';
import 'app/widgets/app_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const String initialRoute = Routes.splash;
  runApp(const App(initialRoute: initialRoute));
}

class App extends StatelessWidget {
  final String initialRoute;

  const App({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      designSize: const Size(411, 823),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        getPages: AppPages.routes,
        initialBinding: AppBindings(),
        smartManagement: SmartManagement.keepFactory,
        title: 'Todo App',
        locale: TranslationService.locale,
        localizationsDelegates: const [
          DefaultCupertinoLocalizations.delegate,
        ],
        fallbackLocale: TranslationService.fallbackLocale,
        translations: TranslationService(),
        initialRoute: initialRoute,
        theme: ThemeData(fontFamily: 'Roboto'),
        builder: EasyLoading.init(),
      ),
    );
  }
}
