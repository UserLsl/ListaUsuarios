import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listviewselection/api.dart';
import 'package:listviewselection/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BuildListView(),
    );
  }
}
class BuildListView extends StatefulWidget {
  const BuildListView({super.key});

  @override
  State<BuildListView> createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        users = lista.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Usuários", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: listaUsuarios(),
    );
  }

  listaUsuarios() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPlwkUTsaWA_zSj0oFI7sbKYXqs-ih3b0_Bg&s'
            ),
          ),
          title: Text(users[index].name ?? 'No Name'),
          subtitle: Text(users[index].email ?? 'No Email'),
          onTap: () {
            Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => DetailPage(users[index])
              ),
            );
          },
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  
  final User user;
  const DetailPage(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name ?? 'No Name'),
      ),
      body: userDetails(),
    );
  }

  userDetails() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: ListTile(
        title: Text(
          user.email ?? 'No Email',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(user.username ?? 'No Username'),
        leading: const Icon(Icons.email, color: Colors.blue),
      ),
    );
  }

}

