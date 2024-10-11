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
      appBar: AppBar(
        title: const Text('التحقق من البصمة'),
        backgroundColor: Colors.blue, // تعديل لون شريط التطبيق
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // لضبط الاتجاه من اليمين إلى اليسار
        child: Container(
          color: Colors.grey[200], // لون الخلفية
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 4, // ارتفاع الظل
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Icon(
                          Icons.fingerprint,
                          size: 60,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _authorized,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: _authenticate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                        ),
                        child: _isAuthenticating
                            ? const Text(
                                'جاري التحقق...',
                                style: TextStyle(fontSize: 18),
                              )
                            : const Text(
                                'تحقق من البصمة',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
