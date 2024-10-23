import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoanCalculator(),
    );
  }
}

class LoanCalculator extends StatefulWidget {
  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  double months = 1; // Default to 1 month
  String result = '';

  void calculateLoan() {
    final double amount = double.tryParse(amountController.text) ?? 0;
    final double percentage = double.tryParse(percentageController.text) ?? 0;

    if (amount > 0 && percentage > 0) {
      double totalRepayment = amount + (amount * (percentage / 100));
      double monthlyPayment = totalRepayment / months;
      result = ' €${monthlyPayment.toStringAsFixed(2)}';
    } else {
      result = 'Please enter valid values.';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Loan Calculator',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Enter the amount', style: TextStyle(fontSize: 16)),
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Enter amount of months',
                style: TextStyle(fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1',
                    style:
                        TextStyle(color: Colors.blue[900])), // Dark blue label
                Expanded(
                  child: Slider(
                    value: months,
                    min: 1,
                    max: 60,
                    divisions: 59,
                    activeColor: Colors.blue[900], // Dark blue for the slider
                    label: months.toInt().toString(),
                    onChanged: (value) {
                      setState(() {
                        months = value;
                      });
                    },
                  ),
                ),
                Text('60 luni',
                    style:
                        TextStyle(color: Colors.blue[900])), // Dark blue label
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Enter % per month', style: TextStyle(fontSize: 16)),
                TextField(
                  controller: percentageController,
                  decoration: const InputDecoration(
                    labelText: 'Percent',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    'You will pay approximately monthly:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    result.isEmpty ? '' : result,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[900]), // Dark blue for result
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateLoan,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Dark blue for button
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Calculate',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
