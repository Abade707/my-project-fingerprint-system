import 'package:flutter/material.dart';

// واجهة تسجيل الدخول
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'admin' && password == 'admin') {
      // إذا كان المستخدم هو المشرف
      Navigator.pushReplacementNamed(context, '/adminHome');
    } else if (username == 'voter' && password == '1234') {
      // إذا كان المستخدم هو الناخب
      Navigator.pushReplacementNamed(context, '/voterHome');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اسم المستخدم أو كلمة المرور غير صحيحة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظام التصويت بالبصمة'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.grey[200],
      body: Directionality(
        textDirection: TextDirection.rtl, // تعيين الاتجاه من اليمين إلى اليسار
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'اسم المستخدم',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    disabledBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  child: const Text('تسجيل الدخول'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
