import 'package:flutter/material.dart';
import 'login_page.dart';            // واجهة تسجيل الدخول
import 'fingerprint_auth_page.dart'; // واجهة التحقق من البصمة
import 'voter_registration_page.dart'; // واجهة تسجيل الناخبين
import 'voting_page.dart';          // واجهة التصويت
import 'results_page.dart';         // واجهة عرض النتائج
import 'settings_page.dart';        // واجهة إعدادات النظام
import 'delete_voter_page.dart';    // واجهة حذف الناخبين

void main() {
  runApp(const VotingApp());
}

class VotingApp extends StatelessWidget {
  const VotingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام التصويت بالبصمة',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',  // الشاشة الأولى عند تشغيل التطبيق
      routes: {
        '/': (context) => const LoginPage(),  // واجهة تسجيل الدخول
        '/fingerprint': (context) => const FingerprintAuthPage(),  // واجهة التحقق من البصمة
        '/register': (context) => const VoterRegistrationPage(),  // واجهة تسجيل الناخبين
        '/voting': (context) => const VotingPage(),  // واجهة التصويت
        '/results': (context) => const ResultsPage(),  // واجهة عرض النتائج
        '/settings': (context) => const SettingsPage(),  // واجهة إعدادات النظام
        '/deleteVoter': (context) => const DeleteVoterPage(),  // واجهة حذف الناخبين
      },
    );
  }
}
