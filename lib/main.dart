import 'package:flutter/material.dart';
import 'package:flutter_application_pw13/lists/state_managers_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentWidget = approaches.values.elementAt(0);
  String appBarTitle = approaches.keys.elementAt(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              const SafeArea(
                  child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Подходы к управлению состоянием:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                ),
              )),
              Expanded(
                child: ListView.builder(
                  itemCount: approaches.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Card(
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(approaches.keys.elementAt(index)),
                        )),
                    onTap: () => setState(() {
                      currentWidget = approaches.values.elementAt(index);
                      appBarTitle = approaches.keys.elementAt(index);
                      Navigator.pop(context);
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: currentWidget,
      ),
    );
  }
}
