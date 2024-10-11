import 'package:flutter/material.dart';
import 'database_helper.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({super.key});

  @override
  VotingPageState createState() => VotingPageState();
}

class VotingPageState extends State<VotingPage> {
  List<Map<String, dynamic>> candidates = [];
  int? selectedCandidateId;

  @override
  void initState() {
    super.initState();
    _loadCandidates();
  }

  void _loadCandidates() async {
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
      appBar: AppBar(
        title: const Text('التصويت'),
        backgroundColor: Colors.blue,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.grey[200],
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: candidates.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        elevation: 4,
                        child: RadioListTile<int>(
                          title: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(candidates[index]['name']),
                          ),
                          value: candidates[index]['id'],
                          groupValue: selectedCandidateId,
                          onChanged: (int? value) {
                            setState(() {
                              selectedCandidateId = value;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _vote,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('تصويت'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
