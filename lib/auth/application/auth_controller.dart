import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mental_health_care/auth/domain/user_model.dart';
import 'package:mental_health_care/core/theme/app_colors.dart';
import 'package:mental_health_care/home/presentation/main_home_page_screen.dart';
import 'package:mental_health_care/routes/app_routes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = Get.find();
  final FirebaseFirestore _firestore = Get.find();
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();
  RxBool disableSignUpButton = false.obs;

  late Timer _timer;

  @override
  void onReady() {
    //run every time the auth state change
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(user);
    super.onReady();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirebaseUser());
    }

    if (_firebaseUser == null) {
      _timer = Timer(const Duration(seconds: 3), () {
        Get.offAllNamed(Routes.ONBOARD);
      });
      print('send to singin');
    } else {
      _timer = Timer(const Duration(seconds: 5), () {
        Get.offAllNamed(Routes.HOME);
      });
    }
  }

  //Firebase user a one-time fetch
  Future<User> get getUser async => _auth.currentUser!;

  //Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();

  //Streams the firestore user from firebase collection
  Stream<UserModel> streamFirebaseUser() {
    UserModel _user = UserModel(uid: '', email: '', name: '', photoUrl: '');

    return _firestore.doc('/users/${firebaseUser.value!.uid}').snapshots().map(
        (snapshot) => snapshot.data() != null
            ? UserModel.fromMap(snapshot.data() as Map<String, dynamic>)
            : _user);
  }

  // user registration using email and password
  void registerWithEmailAndPassword(
      {required String email, required String password}) async {
    disableSignUpButton.value = true;
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        disableSignUpButton.value = false;
        print('Created account successful with $value');
      }).catchError((error) {
        disableSignUpButton.value = false;
        print(error.toString());
      });
   } on FirebaseAuthException catch (e, stack) {
          print('emailSignUp Error: $e $stack');
      disableSignUpButton.value = false;
          Get.snackbar('Email Sign Up', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 10),
          backgroundColor: AppColors.mentalBrandColor,
          colorText: AppColors.mentalBrandLightColor);
    }
  }

  void googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
        await _auth.signInWithCredential(credential).then((value) {
          print('Signed in with google: $value');
        });
      }
    } on FirebaseAuthException catch (e, stack) {
      print('googleSignIn Error: $e $stack');
      Get.snackbar('Google Sign In', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 10),
          backgroundColor: AppColors.mentalBrandColor,
          colorText: AppColors.mentalBrandLightColor);
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
