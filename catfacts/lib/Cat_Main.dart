import "dart:convert";
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class Cat_Main extends StatefulWidget {
  const Cat_Main({super.key});

  @override
  State<Cat_Main> createState() => _Cat_MainState();
}

class _Cat_MainState extends State<Cat_Main> {
  @override
  void initState() {
    super.initState();
    getCatFacts();
  }

  int counter = 1;
  void incCounter() async {
    setState(() {
      counter++;
    });
    await getCatFacts();
  }

  Future<Map<String, dynamic>> getCatFacts() async {
    try {
      final res = await http.get(Uri.parse("https://catfact.ninja/fact"));
      if (res.statusCode != 200) {
        throw Exception(
            'Failed to load cat facts. Status code: ${res.statusCode}');
      }
      final data = jsonDecode(res.body);
      return data;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCatFacts(),
        builder: (context, snapshot) {
          print(snapshot);
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator.adaptive());
          // }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data;
          if (data == null || data['fact'] == null) {
            return const Text('No cat facts available');
          }

          final facts = data['fact'];
          final fact = facts.isNotEmpty ? facts : 'No cat facts available';

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Cat Facts",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Fact # $counter",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        fact,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        incCounter();
                      },
                      color: Colors.purple,
                      child: const Text("Get Facts"),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
