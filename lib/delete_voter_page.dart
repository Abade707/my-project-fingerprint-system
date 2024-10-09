import 'package:flutter/material.dart';
import 'database_helper.dart';

class DeleteVoterPage extends StatefulWidget {
  const DeleteVoterPage({super.key});

  @override
  DeleteVoterPageState createState() => DeleteVoterPageState();
}

class DeleteVoterPageState extends State<DeleteVoterPage> {
  List<Map<String, dynamic>> voters = [];

  @override
  void initState() {
    super.initState();
    _loadVoters();
  }

  void _loadVoters() async {
    List<Map<String, dynamic>> voterList =
        await DatabaseHelper().getAllVoters();
    setState(() {
      voters = voterList;
    });
  }

  void _deleteVoter(int id) async {
    await DatabaseHelper().deleteVoter(id);
    _loadVoters();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حذف الناخب بنجاح')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حذف الناخبين')),
      body: ListView.builder(
        itemCount: voters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // الخانة الأولى للاسم
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            voters[index]['name'],
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            voters[index]['national_id'] ??
                                'رقم وطني غير متوفر',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Text(
                            '01/01/2000 12:00', // تاريخ افتراضي مع ساعة
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16), // مسافة بين الاسم والزر
                    // زر الحذف
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteVoter(voters[index]['id']),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
