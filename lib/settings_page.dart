import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'ar';
  bool _isEncryptionEnabled = false;
  int _sessionDuration = 30;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات النظام'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // تغيير اللغة
            DropdownButton<String>(
              value: _selectedLanguage,
              items: const [
                DropdownMenuItem(value: 'ar', child: Text('العربية')),
                DropdownMenuItem(value: 'en', child: Text('English')),
              ],
              onChanged: (String? value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
            ),
            // مدة الجلسة
            DropdownButton<int>(
              value: _sessionDuration,
              items: const [
                DropdownMenuItem(value: 30, child: Text('30 دقيقة')),
                DropdownMenuItem(value: 45, child: Text('45 دقيقة')),
                DropdownMenuItem(value: 60, child: Text('60 دقيقة')),
              ],
              onChanged: (int? value) {
                setState(() {
                  _sessionDuration = value!;
                });
              },
            ),
            // تفعيل التشفير
            SwitchListTile(
              title: const Text('تفعيل التشفير'),
              value: _isEncryptionEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isEncryptionEnabled = value;
                });
              },
            ),
            // تغيير كلمة المرور
            TextField(
              controller: newPasswordController,
              decoration:
                  const InputDecoration(labelText: 'كلمة المرور الجديدة'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(labelText: 'تأكيد كلمة المرور'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (newPasswordController.text ==
                    confirmPasswordController.text) {
                  // قم بتحديث كلمة المرور هنا
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('تم تغيير كلمة المرور بنجاح')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('كلمة المرور غير متطابقة')));
                }
              },
              child: const Text('تغيير كلمة المرور'),
            ),
          ],
        ),
      ),
    );
  }
}
