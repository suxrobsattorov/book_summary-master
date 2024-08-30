import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/night_day.dart';
import '../../core/utils/texts.dart';
import '../../logic/blocs/all_blocs.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const routeName = '/edit_profile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String surname = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
        title: Texts.textAppBar('Profile settings'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LoadedState) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'name',
                        ),
                        keyboardType: TextInputType.text,
                        initialValue: state.user.name,
                        onSaved: (newValue) => name = newValue!,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'surname',
                        ),
                        keyboardType: TextInputType.text,
                        initialValue: state.user.surname,
                        onSaved: (newValue) => surname = newValue!,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(child: Text('Xatolik sodir bo\'ldi'));
        },
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ElevatedButton(
          onPressed: () {
            _formKey.currentState!.save();
            context.read<UserBloc>().add(UserEditEvent(name, surname));
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CupertinoColors.systemBlue,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Text(
            'Save',
            style: GoogleFonts.aBeeZee(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
