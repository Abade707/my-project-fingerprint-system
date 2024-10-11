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
    results = [
      {'name': 'أحمد محمد', 'vote_count': 12000},
      {'name': 'سارة علي', 'vote_count': 18000},
      {'name': 'يوسف حسن', 'vote_count': 1500},
      {'name': 'ليلى خالد', 'vote_count': 9500},
      {'name': 'علي حسن', 'vote_count': 20000},
      {'name': 'منى سمير', 'vote_count': 8000},
      {'name': 'فاطمة سعيد', 'vote_count': 3000},
    ];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نتائج التصويت'),
        backgroundColor: Colors.blue,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.grey[200],
          child: Center(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DataTable(
                  headingRowColor: WidgetStateColor.resolveWith(
                      (states) => Colors.blue.shade100),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'اسم المرشح',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'عدد الأصوات',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                  rows: results
                      .map(
                        (result) => DataRow(
                          cells: [
                            DataCell(
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  result['name'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  result['vote_count'].toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  border: TableBorder.all(
                    color: Colors.blueAccent,
                    width: 1,
                  ),
                  dataRowColor: WidgetStateColor.resolveWith(
                      (states) => Colors.grey.shade50),
                  headingTextStyle: const TextStyle(
                    color: Colors.black87,
                  ),
                  dataTextStyle: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
