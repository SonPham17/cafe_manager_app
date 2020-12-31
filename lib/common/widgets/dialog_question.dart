import 'package:cafe_manager_app/common/constants/font_constants.dart';
import 'package:cafe_manager_app/features/main_home/presentation/bloc/main_home_cubit.dart';
import 'package:flutter/material.dart';

class DialogQuestion extends StatelessWidget {
  final String i18nLocalizationTitle;
  final String i18nLocalizationContent;
  final String i18nLocalizationConfirmText;
  final String i18nLocalizationCancelText;
  final MainHomeCubit mainHomeCubit;
  final String id;

  DialogQuestion({
    this.id,
    this.i18nLocalizationCancelText,
    this.i18nLocalizationConfirmText,
    this.i18nLocalizationContent,
    this.i18nLocalizationTitle,
    this.mainHomeCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 25.0,
          children: [
            Center(
              child: Text(
                i18nLocalizationTitle,
                style: const TextStyle(
                    color: Color.fromRGBO(132, 62, 187, 1),
                    fontSize: 20,
                    fontFamily: FontConstants.montserratBold,
                    letterSpacing: -0.78),
              ),
            ),
            Text(
              i18nLocalizationContent,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                  color: Color.fromRGBO(95, 95, 95, 1),
                  fontSize: 14,
                  fontFamily: FontConstants.montserratRegular),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        mainHomeCubit.deleteChef(id);
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(132, 62, 187, 1)),
                            child: Center(
                              child: Text(
                                i18nLocalizationConfirmText,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily:
                                        FontConstants.montserratRegular),
                              ),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(132, 62, 187, 1)),
                            child: Center(
                              child: Text(
                                i18nLocalizationCancelText,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily:
                                        FontConstants.montserratRegular),
                              ),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
