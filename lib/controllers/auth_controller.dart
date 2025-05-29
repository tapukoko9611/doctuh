import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isLoggedIn = false.obs;
  var currentUser = Rxn<User>();
  var showPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void toggleShowPassword() {
    showPassword(!showPassword.value);
  }

  Future<void> checkLoginStatus() async {
    isLoading(true);
    errorMessage('');
    try {
      final user = await _authService.getLoggedInUser();
      if (user != null) {
        currentUser.value = user;
        isLoggedIn.value = true;
      } else {
        isLoggedIn.value = false;
        currentUser.value = null;
      }
    } catch (e) {
      print('Error checking login status: $e');
      isLoggedIn.value = false;
      currentUser.value = null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> login(String emailOrMobile, String password) async {
    isLoading(true);
    errorMessage('');
    try {
      final user = await _authService.login(emailOrMobile, password);
      print(user);
      if (user != null) {
        currentUser.value = user;
        isLoggedIn.value = true;
        Get.offAllNamed('/home');
      } else {
        errorMessage('Invalid email/mobile or password...');
      }
    } catch (e) {
      errorMessage('Login failed: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> signUp(String name, String email, String countryCode, String mobileNumber, String password) async {
    isLoading(true);
    errorMessage('');
    print("$name, $email, $countryCode, $mobileNumber, $password");
    try {
      final newUser = User(
        name: name,
        email: email,
        countryCode: countryCode,
        mobileNumber: mobileNumber,
        password: password,
      );
      final success = await _authService.signUp(newUser);
      if (success) {
        Get.offAllNamed('/login');
        Get.snackbar('Success', 'Account created! Please log in...', snackPosition: SnackPosition.BOTTOM);
      } else {
        errorMessage('Email or Mobile Number already registered.'); // Updated error message
      }
    } catch (e) {
      errorMessage('Signup failed: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    isLoading(true);
    errorMessage('');
    try {
      await _authService.logout();
      isLoggedIn.value = false;
      currentUser.value = null;
      Get.offAllNamed('/login');
    } catch (e) {
      errorMessage('Logout failed: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}