import 'package:flutter/material.dart';
import 'database_helper.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({super.key});

  @override
  VotingPageState createState() => VotingPageState();
}

class VotingPageState extends State<VotingPage> {
  List<Map<String, dynamic>> candidates = [];
  int? selectedCandidateId; // لتخزين ID المرشح المختار

  @override
  void initState() {
    super.initState();
    _loadCandidates();
  }

  void _loadCandidates() async {
    // هنا نضيف المرشحين مباشرة بأسماء عادية
    candidates = [
      {'id': 1, 'name': 'أحمد محمد'},
      {'id': 2, 'name': 'سارة علي'},
      {'id': 3, 'name': 'يوسف حسن'},
      {'id': 4, 'name': 'ليلى خالد'},
      {'id': 5, 'name': 'علي حسن'},
      {'id': 6, 'name': 'منى سمير'},
      {'id': 7, 'name': 'فاطمة سعيد'},
    ];

    setState(() {
      // تحديث الحالة بعد إضافة المرشحين
    });
  }

  void _vote() async {
    if (selectedCandidateId != null) {
      Map<String, dynamic> vote = {
        'voter_id': 1, // مثال: ID الناخب
        'candidate_id': selectedCandidateId,
      };
      await DatabaseHelper().insertVote(vote);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم التصويت بنجاح')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التصويت')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: candidates.length,
              itemBuilder: (context, index) {
                return RadioListTile<int>(
                  title: Text(candidates[index]['name']),
                  value: candidates[index]['id'],
                  groupValue: selectedCandidateId,
                  onChanged: (int? value) {
                    setState(() {
                      selectedCandidateId = value;
                    });
                  },
                );
              },
            ),
          ),
          // زر التصويت في الأسفل
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _vote,
              child: const Text('تصويت'),
            ),
          ),
        ],
      ),
    );
  }
}
