import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // إضافة مكتبات الترجمات المحلية
import 'login_page.dart';
import 'fingerprint_auth_page.dart';
import 'voter_registration_page.dart';
import 'voting_page.dart';
import 'results_page.dart';
import 'settings_page.dart';
import 'delete_voter_page.dart';
import 'admin_home_page.dart';
import 'voter_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام التصويت بالبصمة',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      locale: const Locale('ar', 'EG'), // تعيين اللغة العربية كلغة افتراضية
      supportedLocales: const [
        Locale('ar', 'EG'), // العربية
        Locale('en', 'US'), // الإنجليزية
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/fingerprint': (context) => const FingerprintAuthPage(),
        '/register': (context) => const VoterRegistrationPage(),
        '/voting': (context) => const VotingPage(),
        '/results': (context) => const ResultsPage(),
        '/settings': (context) => const SettingsPage(),
        '/deleteVoter': (context) => const DeleteVoterPage(),
        '/adminHome': (context) => const AdminHomePage(),
        '/voterHome': (context) => const VoterHomePage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      },
    );
  }
}
