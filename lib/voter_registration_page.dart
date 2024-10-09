import 'package:flutter/material.dart';
import 'database_helper.dart';

class VoterRegistrationPage extends StatefulWidget {
  const VoterRegistrationPage({super.key});

  @override
  VoterRegistrationPageState createState() => VoterRegistrationPageState();
}

class VoterRegistrationPageState extends State<VoterRegistrationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();

  void _addVoter() async {
    String name = nameController.text;
    String nationalId = nationalIdController.text;

    if (name.isNotEmpty && nationalId.isNotEmpty) {
      Map<String, dynamic> voter = {
        'name': name,
        'national_id': nationalId,
        'has_voted': 0,
      };

      await DatabaseHelper().insertVoter(voter);
      // تحقق من أن الحالة لا تزال مركبة قبل استخدام BuildContext
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تسجيل الناخب بنجاح')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الناخبين')),
      body: Directionality(
        textDirection: TextDirection.rtl, // تعيين الاتجاه من اليمين إلى اليسار
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'اسم الناخب'),
              ),
              TextField(
                controller: nationalIdController,
                decoration: const InputDecoration(labelText: 'الرقم الوطني'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addVoter,
                child: const Text('إضافة الناخب'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
