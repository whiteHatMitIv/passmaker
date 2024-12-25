import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:passmaker/bloc/password_cubit.dart';
import 'package:passmaker/screens/main_page.dart';
import 'package:passmaker/screens/welcome_page.dart';
import 'package:passmaker/utils/theme/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBloc.storage = storage;

  final prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  runApp(App(hasSeenOnboarding: hasSeenOnboarding));
}

class App extends StatelessWidget {
  final bool hasSeenOnboarding;
  
  const App({
    super.key,
    required this.hasSeenOnboarding
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordCubit(),
      child: GetMaterialApp(
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: hasSeenOnboarding ? MainPage() : WelcomePage(),
      ),
    );
  }
}

