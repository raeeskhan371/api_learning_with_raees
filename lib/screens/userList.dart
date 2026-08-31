import 'package:api_learning/models/UserModel.dart';
import 'package:api_learning/services/api_services.dart';
import 'package:flutter/material.dart';

class Userlist extends StatefulWidget {
  const new({super.key});

  @override
  State<Userlist> createState() => _UserlistState();
}

class _UserlistState extends State<Userlist> {
  final ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<UserModel>>(
            future: apiServices.getUser(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot == null) {
                return CircularProgressIndicator(color: Colors.blue);
              }
              final Userlist = snapshot.data!;

              return Expanded(
                child: ListView.builder(
                  itemCount: Userlist.length,
                  itemBuilder: (context, index) {
                    final item = Userlist[index];
                    return ListTile(
                      leading: Text(item.id.toString()),
                      title: Text("Name: ${item.name.toString()}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("email:  ${item.email.toString()}"),
                          Text("phone: ${item.phone.toString()}"),
                          Text("city: ${item.address!.city.toString()}"),
                          Text("company ${item.company!.name.toString()}"),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
