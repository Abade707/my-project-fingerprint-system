import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'voting_page.dart';

class FingerprintAuthPage extends StatefulWidget {
  const FingerprintAuthPage({super.key});

  @override
  FingerprintAuthPageState createState() => FingerprintAuthPageState();
}

class FingerprintAuthPageState extends State<FingerprintAuthPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;
  String _authorized = 'غير مصرح';

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'جاري التحقق من البصمة...';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'الرجاء مسح بصمتك للتحقق من الهوية',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = authenticated ? 'تم المصادقة' : 'فشلت المصادقة';
      });

      if (authenticated) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const VotingPage()),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'حدث خطأ: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التحقق من البصمة')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // خانة محاكاة للبصمة
              Container(
                width: 100, // عرض الخانة
                height: 100, // ارتفاع الخانة
                decoration: BoxDecoration(
                  color: Colors.grey.shade300, // لون الخلفية
                  borderRadius: BorderRadius.circular(10), // زوايا دائرية
                  border: Border.all(color: Colors.grey), // حد للخانة
                ),
                child: const Icon(
                  Icons.fingerprint, // أيقونة بصمة
                  size: 60, // حجم الأيقونة
                  color: Colors.black54, // لون الأيقونة
                ),
              ),
              const SizedBox(height: 20),
              Text(_authorized),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _authenticate,
                child: _isAuthenticating
                    ? const Text('جاري التحقق...')
                    : const Text('تحقق من البصمة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
