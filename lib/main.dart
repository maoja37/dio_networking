import 'package:dio_networking/model/data.dart';
import 'package:dio_networking/model/user.dart';
import 'package:dio_networking/service/dio_client.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio Networking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: Center(
        child: FutureBuilder<User?>(
          future: _client.getUser(id: '1'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              debugPrint('waiting');
              return const CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                User? userInfo = snapshot.data;
                if (userInfo != null) {
                  Data userData = userInfo.data;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          onTap: (() => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const Drop()))),
                          child: Image.network(userData.avatar)),
                      const SizedBox(height: 8.0),
                      Text(
                        '${userInfo.data.firstName} ${userInfo.data.lastName}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        userData.email,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  );
                }
              } else {
                debugPrint('no data');
              }
            }
            debugPrint('nothing done');
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class Drop extends StatefulWidget {
  const Drop({Key? key}) : super(key: key);

  @override
  State<Drop> createState() => _DropState();
}

class _DropState extends State<Drop> {
  @override
  Widget build(BuildContext context) {
    List<String> stringItems = [
      'Abia 1',
      'Adamawa',
      'Akwa Ibom',
      'Anambra',
      'Abia',
      'Adamawa',
      'Akwa Ibom',
      'Anambra'
    ];
    String? _dropdownValue;
    return Scaffold(
      appBar: AppBar(
          title: const SafeArea(
        child: SizedBox(
          height: 20,
        ),
      )),
      body: Center(
        child: Card(
          shape: const StadiumBorder(),
          child: DropdownButton(
            iconSize: 0,
            hint: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text('Please choose a location'),
            ),
            isExpanded: true,
            underline: Container(),
            itemHeight: 65,
            borderRadius: BorderRadius.circular(30),
            value: _dropdownValue,
            items: stringItems.map((value) {
              return DropdownMenuItem(
                value: value,
                child: getListTile(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _dropdownValue = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget getListTile(String value) {
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      height: 100,
      width: 380,
      child: Column(
        children: [
          ListTile(
            title: Text(value),
            trailing: const Icon(
              Icons.euro_symbol,
              size: 15,
            ),
          ),
          const Divider(
            height: 5,
            color: Colors.black,
            indent: 0,
          )
        ],
      ),
    );
  }
}
