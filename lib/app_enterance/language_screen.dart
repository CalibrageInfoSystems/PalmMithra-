/* // ignore_for_file: use_build_context_synchronously

import 'package:akshaya_flutter/common_utils/common_styles.dart';
import 'package:akshaya_flutter/common_utils/shared_prefs_keys.dart';
import 'package:akshaya_flutter/localization/app_locale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/login_screen.dart';
import '../common_utils/constants.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Please Select Language Below:',
                style: CommonStyles
                    .text18orange, // Assuming you have this style defined
              ),
              const SizedBox(height: 20),
              _buildLanguageButton(context, 'English', onPressed: () {
                saveDataAndNavigate(context,
                    language: Constants.englishLanguage,
                    locale: AppLocal.englishLocale);
              }),
              const SizedBox(height: 16),
              _buildLanguageButton(context, 'Telugu', onPressed: () {
                saveDataAndNavigate(context,
                    language: Constants.teluguLanguage,
                    locale: AppLocal.teluguLocale);
              }),
              const SizedBox(height: 16),
              _buildLanguageButton(context, 'Kannada', onPressed: () {
                saveDataAndNavigate(context,
                    language: Constants.kannadaLanguage,
                    locale: AppLocal.kannadaLocale);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context, String language,
      {required void Function()? onPressed}) {
    return SizedBox(
      width: double.infinity,
      // Makes the button take up the full width of its parent
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCCCCCC), // Start color (light gray)
              Color(0xFFFFFFFF), // Center color (white)
              Color(0xFFCCCCCC), // End color (light gray)
            ],
          ),
          border: Border.all(
            color: const Color(0xFFe86100), // Orange border color
            width: 2.0,
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,

          /* () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool(Constants.welcome, true);
            context.go(Routes.loginScreen.path);
          }, */
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 0),
            backgroundColor:
                Colors.transparent, // Transparent to show the gradient
            shadowColor: Colors.transparent, // Remove button shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Text(
            language,
            style: CommonStyles.text18orange,
          ),
        ),
      ),
    );
  }

  Future<void> saveDataAndNavigate(BuildContext context,
      {required String language, required Locale locale}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constants.welcome, true);
    prefs.setString(SharedPrefsKeys.language, language);
    context.setLocale(locale);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
    //   context.go(Routes.loginScreen.path);
  }
}
 */

import 'package:akshaya_flutter/authentication/login_screen.dart';
import 'package:akshaya_flutter/common_utils/Constants.dart';
import 'package:akshaya_flutter/common_utils/shared_prefs_keys.dart';
import 'package:akshaya_flutter/gen/assets.gen.dart';
import 'package:akshaya_flutter/localization/app_locale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? selectedLanguage;

  final languages = [
    {'label': 'English', 'icon': Icons.language},
    {'label': 'తెలుగు', 'icon': Icons.language},
    {'label': 'ಕನ್ನಡ', 'icon': Icons.language},
  ];

  final locales = [
    {'label': Constants.englishLanguage, 'locale': AppLocal.englishLocale},
    {'label': Constants.teluguLanguage, 'locale': AppLocal.teluguLocale},
    {'label': Constants.kannadaLanguage, 'locale': AppLocal.kannadaLocale},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 248, 228, 204),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xFFF8EAD9),
                  child: SvgPicture.asset(
                    Assets.images.languageExchange.path,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                    color: Color(0xFF4CAF50),
                  )
                  // Icon(Icons.translate, size: 50, color: Color(0xFF4CAF50),),
                  ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Your Language',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final lang = languages[index];
                  bool isSelected = selectedLanguage == lang['label'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        print('Selected Language: ${lang['label']}');
                        selectedLanguage = lang['label'] as String;
                        saveDataAndNavigate(context,
                            language: locales[index]['label'] as String,
                            locale: locales[index]['locale'] as Locale);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE9FBE6)
                            : const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(
                                color: const Color(0xFF80C683), width: 2)
                            : null,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.black,
                              child: SvgPicture.asset(
                                getIcon(lang['label'] as String),
                                fit: BoxFit.contain,
                                color: lang['label'] == 'ಕನ್ನಡ'
                                    ? Colors.white
                                    : null,
                              )),
                          const SizedBox(width: 20),
                          Text(
                            '${lang['label']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            /*  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF08070),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    const Text('NEXT', style: TextStyle(color: Colors.white)),
              ),
            ), */
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  String getIcon(String language) {
    switch (language) {
      case 'English':
        return Assets.images.iconEnglish.path;
      case 'తెలుగు':
        return Assets.images.iconTelugu.path;
      case 'ಕನ್ನಡ':
        return Assets.images.languageKannada.path;
      default:
        return Assets.images.languageExchange.path;
    }
  }

  Future<void> saveDataAndNavigate(BuildContext context,
      {required String language, required Locale locale}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constants.welcome, true);
    prefs.setString(SharedPrefsKeys.language, language);
    context.setLocale(locale);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
    //   context.go(Routes.loginScreen.path);
  }
}
