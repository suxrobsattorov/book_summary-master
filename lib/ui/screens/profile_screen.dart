import 'package:book_summary/ui/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/night_day.dart';
import '../../core/utils/texts.dart';
import '../../logic/blocs/all_blocs.dart';
import '../widgets/list_button_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
        title: Texts.textAppBar('Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 200,
                        width: 250,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://static.vecteezy.com/system/resources/thumbnails/027/951/137/small_2x/stylish-spectacles-guy-3d-avatar-character-illustrations-png.png',
                            ),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            style: BorderStyle.solid,
                            color: const Color(0xFF02CCAA),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Texts.text16Brown('Name'),
                  ],
                ),
                const SizedBox(height: 30),
                ListButtonContainer(text: 'Sevimli kitoblar'),
                ListButtonContainer(text: 'Tarix'),
                ListButtonContainer(text: 'Profilni sozlash'),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Texts.text16Brown('Haqiqatdan ham chiqmoqchimisiz'),
                content: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const AuthScreen();
                            },
                          ),
                        );
                      },
                      child: Texts.text18('Tasdiqlash'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Texts.text18White('Chiqish'),
        ),
      ),
    );
  }
}
