import 'package:dicoding_voiceapp/helper/router_index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/app_color.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -50,
                  right: -90,
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      'assets/images/icons/voiceapp.png',
                      height: 280,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Aing maung',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              context.goNamed(RouterIndex.homePage);
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long_rounded),
            title: const Text('History'),
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(RouterIndex.history);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: AppColors.errorColor,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: AppColors.errorColor, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.pop(context);
              context.goNamed(RouterIndex.auth);
            },
          ),
        ],
      ),
    );
  }
}
