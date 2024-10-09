import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  ResultsPageState createState() => ResultsPageState();
}

class ResultsPageState extends State<ResultsPage> {
  List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  void _loadResults() async {
    // محاكاة بيانات حقيقية
    results = [
      {'name': 'أحمد محمد', 'vote_count': 12000},
      {'name': 'سارة علي', 'vote_count': 18000},
      {'name': 'يوسف حسن', 'vote_count': 1500},
      {'name': 'ليلى خالد', 'vote_count': 9500},
      {'name': 'علي حسن', 'vote_count': 20000},
      {'name': 'منى سمير', 'vote_count': 8000},
      {'name': 'فاطمة سعيد', 'vote_count': 3000},
    ];

    // إذا كنت تستخدم قاعدة البيانات، يمكنك استخدام الكود التالي
    // List<Map<String, dynamic>> resultList =
    //     await DatabaseHelper().getVoteResults();
    // setState(() {
    //   results = resultList;
    // });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نتائج التصويت')),
      body: SingleChildScrollView(
        child: Center(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('اسم المرشح')),
              DataColumn(label: Text('عدد الأصوات')),
            ],
            rows: results
                .map(
                  (result) => DataRow(cells: [
                    DataCell(Text(result['name'])),
                    DataCell(Text(result['vote_count'].toString())),
                  ]),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
