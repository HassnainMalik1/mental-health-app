import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mental_health_care/auth/application/auth_controller.dart';
import 'package:mental_health_care/launchscreen/application/welcome_controller.dart';
import 'package:mental_health_care/onboard/application/onboard_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() async {
    await initalizeFirebase();
    // Get.put<WelcomeController>(WelcomeController());
    Get.put<OnBoardingController>(OnBoardingController());
    Get.put<AuthController>(AuthController(), permanent: true);
  }

  Future initalizeFirebase() async {
    Get.lazyPut<FirebaseAuth>(() => FirebaseAuth.instance, fenix: true);
    Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance,
        fenix: true);
  }
}
