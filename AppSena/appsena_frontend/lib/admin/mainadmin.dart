import 'package:appsena_frontend/admin/authadmin.dart';
import 'package:appsena_frontend/admin/homeadmin.dart';
import 'package:appsena_frontend/models/botton_icons.dart';
import 'package:appsena_frontend/pages/explorepage.dart';
import 'package:appsena_frontend/pages/questionspage.dart';
import 'package:flutter/material.dart';

class MainAdmin extends StatefulWidget {
  const MainAdmin({super.key});

  @override
  State<MainAdmin> createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    Widget body() {
      switch (currentPage) {
        case 0:
          return const HomeAdmin();
        case 1:
          return const Questions();
        case 2:
          return const ExplorePage();
        case 3:
          return const AuthAdmin();
        default:
          return const Center(
            child: Text(
              'Ha ocurrido un error 404',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
              ),
            ),
          );
      }
    }

    return Scaffold(
      body: body(),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 86,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...List.generate(
              bottomIcons.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    currentPage = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      currentPage == index
                          ? bottomIcons[index].selected
                          : bottomIcons[index].unselected,
                      color: Colors.green[700],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: Colors.green[900],
                        shape: BoxShape.circle,
                      ),
                      width: currentPage == index ? 7 : 0,
                      height: currentPage == index ? 7 : 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
