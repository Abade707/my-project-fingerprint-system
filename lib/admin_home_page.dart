import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية للمشرف'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('تسجيل الناخبين'),
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('إعدادات النظام'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/deleteVoter');
              },
              child: const Text('حذف الناخبين'),
            ),
          ],
        ),
      ),
    );
  }
}
