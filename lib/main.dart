import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_clone/business_logic/blocs/authentication_bloc.dart';
import 'package:linkedin_clone/business_logic/blocs/sign_in/sign_in_bloc.dart';
import 'package:linkedin_clone/data/repository/authentication_repository.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';
import 'package:linkedin_clone/routes.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    printLogs('***** MAIN BUILD CALLED!!! *********');
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            authenticationRepository: AuthenticationRepository(),
          ),
        ),
        BlocProvider<SignInBloc>(
          create: (BuildContext context) => SignInBloc(
            authenticationRepository: AuthenticationRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'LinkedIn Clone',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
          useMaterial3: true,
        ),
        onGenerateRoute: router.Router.generateRoute,
        initialRoute: router.ScreenRoutes.toSplashScreen,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
