import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mental_health_care/auth/domain/user_model.dart';
import 'package:mental_health_care/core/theme/app_colors.dart';

import 'package:mental_health_care/routes/app_routes.dart';
import 'package:mental_health_care/ui/custom_models.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = Get.find();
  final FirebaseFirestore _firestore = Get.find();
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();
  RxBool disableSignUpButton = false.obs;
  RxBool disableSignInButton = false.obs;
  RxBool disableResetPasswordButton = false.obs;

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

  // Method to handle user sign in with email
  signInWithEmailAndPassword(
      {required String email, required String password}) async {
    disableSignInButton.value = true;
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        disableSignInButton.value = false;
      });
    } on FirebaseAuthException catch (e, stack) {
      print('emailSignUp Error: $e $stack');
      disableSignInButton.value = false;
      Get.snackbar('Email Sign Up', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 10),
          backgroundColor: AppColors.mentalBrandColor,
          colorText: AppColors.mentalBrandLightColor);
    }
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

  signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final AuthorizationCredentialAppleID appleCredential;

      if (GetPlatform.isAndroid) {
        appleCredential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            webAuthenticationOptions: WebAuthenticationOptions(
                clientId: '', redirectUri: Uri.parse('')),
            nonce: nonce);
      }

      final appleCredentials =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);
      final authCredentials = await OAuthProvider('apple.com').credential(
          idToken: appleCredentials.identityToken,
          accessToken: appleCredentials.authorizationCode, rawNonce: rawNonce);
      await _auth.signInWithCredential(authCredentials).then((value) {
        print('Signed in with apple $value');
      });
    } on FirebaseAuthException catch (e, stack) {
      print('appleSignIn Error: $e $stack');
      disableResetPasswordButton.value = false;
      Get.snackbar('Apple Sign In', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 10),
          backgroundColor: AppColors.mentalBrandColor,
          colorText: AppColors.mentalBrandLightColor);
    }
  }

   /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  //method to handle rest password request
  void userForgetPassword(
      {required String email, required BuildContext context}) async {
    try {
      disableResetPasswordButton.value = true;
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        customBottomSheet(
            content: Text('Hello model'),
            context: context,
            title: '',
            onPressed: () async {
              var result = await OpenMailApp.openMailApp();
              if (!result.didOpen && !result.canOpen) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Open Mail App"),
                      content: Text("No mail apps installed"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                );
              } else if (!result.didOpen && result.canOpen) {
                showDialog(
                    context: context,
                    builder: (_) =>
                        MailAppPickerDialog(mailApps: result.options));
              }
            });
        disableResetPasswordButton.value = false;
      });
    } on FirebaseAuthException catch (e, stack) {
      print('resendPassword Error: $e $stack');
      disableResetPasswordButton.value = false;
      Get.snackbar('Forget Password', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 10),
          backgroundColor: AppColors.mentalBrandColor,
          colorText: AppColors.mentalBrandLightColor);
    }
  }

  void googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      ).signIn();
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

  void facebookSignIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile']);

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        print('user data : $userData');
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        _auth.signInWithCredential(facebookAuthCredential).then((value) {
          print('Signed in with facebook $value');
        });
      }
    } on FirebaseAuthException catch (e, stack) {
      print('facebookSignIn Error: $e $stack');
      Get.snackbar('FAcebook Sign In', e.message!,
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
