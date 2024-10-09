import 'package:flutter/material.dart';

class VoterHomePage extends StatelessWidget {
  const VoterHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية للناخب'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/fingerprint');
              },
              child: const Text('التحقق من البصمة'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/voting');
              },
              child: const Text('التصويت'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/results');
              },
              child: const Text('عرض النتائج'),
            ),
          ],
        ),
      ),
    );
  }
}
