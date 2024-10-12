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
      appBar: AppBar(
        title: const Text('حذف الناخبين'),
        backgroundColor: Colors.blueAccent, // لون الشريط العلوي
      ),
      body: Container(
        color: Colors.grey[200], // لون الخلفية
        padding: const EdgeInsets.all(16.0),
        child: voters.isEmpty
            ? const Center(
                child: Text(
                  'لا يوجد ناخبين لعرضهم',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              )
            : ListView.builder(
                itemCount: voters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      color: Colors.white, // لون البطاقة
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // حواف دائرية
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            voters[index]['name'][0], // أول حرف من الاسم
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        title: Text(
                          voters[index]['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الرقم الوطني: ${voters[index]['national_id'] ?? 'غير متوفر'}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              '01/01/2000 12:00', // تاريخ افتراضي مع ساعة
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteVoter(voters[index]['id']),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
