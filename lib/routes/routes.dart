import 'package:busbooking/screens/welcome_screen.dart';
import 'package:get/get.dart';
import '../bindings/signin_binding.dart';
import '../screens/sign_in_screen.dart';
import '../splash_screen.dart';

const String splash = '/splash-screen';
const String welcome = '/welcome-screen';
const String signinscreen = '/signin-screen';
const String basescreen = '/base-screen';

List<GetPage> myroutes = [
  GetPage(name: splash, page: () => SplashScreen()),

  GetPage(name: welcome, page: () => WelcomeScreen()),

  GetPage(
    name: signinscreen,
    page: () => SignInScreen(),
    binding: SignInBinding(),
  ),
];
