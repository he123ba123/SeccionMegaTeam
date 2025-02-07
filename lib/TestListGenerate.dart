import 'package:flutter/material.dart';

class TestListGenerate extends StatefulWidget {
  const TestListGenerate({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GenderSelectionPageState createState() => _GenderSelectionPageState();
}

class _GenderSelectionPageState extends State<TestListGenerate> {
  @override
  void initState() {
    print("Year screen");
    super.initState();
  }

  @override
  void dispose() {
    print(" deleteList generate");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PopupMenuButton '),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: DropdownButton<int>(
              hint: const Text(
                'Select Year',
                style: TextStyle(fontSize: 20, color: Colors.deepPurple),
              ),
              items: List.generate(80, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text(
                    "${1950 + index}",
                    style: const TextStyle(color: Colors.pink, fontSize: 20),
                  ),
                );
              }),
              onChanged: (int? index) {},
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
            child: const Text("Go to home page"),
          )
        ],
      ),
    );
  }
}
