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
        backgroundColor: Colors.blue,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.grey[200],
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
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
                      underline: Container(),
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<int>(
                      isExpanded: true,
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
                      underline: Container(),
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 4,
                  child: SwitchListTile(
                    title: const Text('تفعيل التشفير'),
                    value: _isEncryptionEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _isEncryptionEnabled = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: newPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'كلمة المرور الجديدة',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'تأكيد كلمة المرور',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (newPasswordController.text ==
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('تم تغيير كلمة المرور بنجاح')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('كلمة المرور غير متطابقة')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text('تغيير كلمة المرور'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
