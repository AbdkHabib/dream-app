import 'package:dream/screens/admin_screens/all_dream_screen.dart';
import 'package:dream/screens/admin_screens/commentator_accounts_screen.dart';
import 'package:dream/screens/admin_screens/connect_read_screen.dart';
import 'package:dream/screens/admin_screens/users_account_screen.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('لوحة التحكم'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'المفسرين',
              ),
              Tab(
                text: 'المستخدمين',
              ),
              Tab(
                text: 'الاحلام',
              ),
              Tab(
                text: 'الرسائل',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const CommenterAccountScreen(),
            const UsersAccountScreen(),
            const AllDreamScreen(),
            const ConnectReadScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/add_accounts_screen');
          },
          backgroundColor: Colors.red,
          label: const Text('اضافة مفسر'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
