import 'package:book_summary/logic/blocs/user/user_bloc.dart';
import 'package:book_summary/ui/screens/auth_screen.dart';
import 'package:book_summary/ui/screens/books_history_screen.dart';
import 'package:book_summary/ui/screens/edit_profile_screen.dart';
import 'package:book_summary/ui/screens/saved_books_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/night_day.dart';
import '../../core/utils/texts.dart';
import '../../logic/blocs/all_blocs.dart';
import '../widgets/list_button_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

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
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is LoadedState) {
                          return Texts.text16Brown(state.user.name.isNotEmpty
                              ? '${state.user.name} ${state.user.surname}'
                              : 'Name');
                        }
                        if (state is LoadingState) {
                          return const Center(
                            child: Text('Xatolik sodir bo\'ldi'),
                          );
                        }
                        return const Center(
                          child: Text('name'),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    context.read<BooksBloc>().add(GetBooksEvent());
                    Navigator.of(context).pushNamed(SavedBooksScreen.routeName);
                  },
                  child: ListButtonContainer(text: 'Sevimli kitoblar'),
                ),
                InkWell(
                  onTap: () {
                    context.read<BooksBloc>().add(GetBooksEvent());
                    Navigator.of(context).pushNamed(BooksHistoryScreen.routeName);
                  },
                  child: ListButtonContainer(text: 'Tarix'),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const EditProfileScreen();
                      },
                    ));
                  },
                  child: ListButtonContainer(text: 'Profilni sozlash'),
                ),
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
