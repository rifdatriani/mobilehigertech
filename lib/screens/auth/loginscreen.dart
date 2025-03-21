import 'package:flutter/material.dart';
import 'package:mobilehigertech/screens/home_screen.dart';
import 'package:mobilehigertech/screens/auth/login/rememberme.dart'; // 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // ignore: unused_field
  bool _obscureText = true; // Variabel untuk mengontrol tampilan password
  // ignore: unused_field
  bool _rememberMe = false; // Variabel untuk menyimpan status Remember Me

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    
    if (username == "admin" && password == "12345678") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username atau password salah!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/hgt.png', width: 100),
                const SizedBox(height: 10),
                const Text(
                  "Silahkan login untuk mengakses aplikasi",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText; // Toggle visibility
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Gunakan RememberMeCheckbox
                RememberMeCheckbox(
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                ),

                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Login"),
                ),
                
                const SizedBox(height: 10),
                const Text.rich(
                  TextSpan(
                    text: "Powered By\n",
                    children: [
                      TextSpan(
                        text: "PT. Higertech Karya Sinergi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
