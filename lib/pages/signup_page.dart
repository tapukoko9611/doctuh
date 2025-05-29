import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SignUpPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController(text: '+91');
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/doctor.png', // Your logo path
                height: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                'Your Doctor',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 40),
              
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'name',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: TextField(
                      controller: countryCodeController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Code',
                        hintText: '+XX',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: TextField(
                      controller: mobileNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        hintText: 'Enter your mobile number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.phone),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Obx(() => TextField(
                controller: passwordController,
                obscureText: authController.showPassword.value? false: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Create a password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: authController.showPassword.value? const Icon(Icons.visibility_off): const Icon(Icons.visibility),
                    onPressed: () {
                      authController.toggleShowPassword();
                    },
                  ),
                ),
              )),
              const SizedBox(height: 30),

              Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      nameController.text.isEmpty ||
                      mobileNumberController.text.isEmpty ||
                      countryCodeController.text.isEmpty) {
                    Get.snackbar('Error', 'Please fill all fields...', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red.withOpacity(0.7), colorText: Colors.white);
                    return;
                  }
                  authController.signUp(
                    nameController.text.trim(),
                    emailController.text.trim(),
                    countryCodeController.text.trim(), // Pass country code
                    mobileNumberController.text.trim(), // Pass mobile number
                    passwordController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )),
              Obx(() => authController.errorMessage.isNotEmpty
                  ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  authController.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              )
                  : const SizedBox.shrink()),
              const SizedBox(height: 20),

              const Text('Or continue with'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialButton(
                    'assets/facebook_logo.png', // Add Facebook logo to assets
                        () {
                      Get.snackbar('Coming Soon', 'Facebook signup not implemented...', snackPosition: SnackPosition.BOTTOM);
                    },
                  ),
                  const SizedBox(width: 20),
                  _socialButton(
                    'assets/google_logo.png', // Add Google logo to assets
                        () {
                      Get.snackbar('Coming Soon', 'Google signup not implemented...', snackPosition: SnackPosition.BOTTOM);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Have an account already?"),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/login'); // Navigate back to login page
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String imagePath, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          imagePath,
          height: 30,
        ),
      ),
    );
  }
}