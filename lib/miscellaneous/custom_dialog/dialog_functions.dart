import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:flutter/material.dart';

class OkDialog {
  BuildContext context;
  String? title;
  String content;
  Function? okPressed;
  bool? headIcon;

  OkDialog({
    required this.context,
    this.title,
    required this.content,
    this.okPressed,
    this.headIcon,
  });

  show() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          icon: headIcon != null ?
          headIcon! == true ?
          const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ) :
          const Icon(
            Icons.cancel_outlined,
            color: Colors.red,
          ) :
          const Icon(
            Icons.warning,
            color: Colors.yellow,
          ),
          title: Text(
            title != null ? title! : headIcon != null ? headIcon! == true ? 'Sukses' : 'Gagal' : 'Perhatian',
            style: TextStyle(
              color: title != null ? Colors.black : headIcon != null ? headIcon! == true ? Colors.green : Colors.red : Colors.black,
            ),
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                CloseBack(context: context).go();
              },
              child: const Text(
                'Oke',
              ),
            ),
          ],
        );
      },
    ).then((_) {
      if(okPressed != null) {
        okPressed!();
      }
    });
  }
}

class OptionDialog {
  BuildContext context;
  String? title;
  String content;
  Function? yesPressed;
  Function? noPressed;

  OptionDialog({
    required this.context,
    this.title,
    required this.content,
    this.yesPressed,
    this.noPressed,
  });

  show() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning,
            color: Colors.yellow,
          ),
          title: Text(
            title ?? 'Perhatian',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                CloseBack(context: context, callbackData: false).go();
              },
              child: const Text(
                'Tidak',
              ),
            ),
            TextButton(
              onPressed: () {
                CloseBack(context: context, callbackData: true).go();
              },
              child: const Text(
                '  Ya  ',
              ),
            ),
          ],
        );
      },
    ).then((dialogResult) {
      if(dialogResult != null) {
        if(dialogResult == true) {
          if(yesPressed != null) {
            yesPressed!();
          }
        } else {
          if(noPressed != null) {
            noPressed!();
          }
        }
      }
    });
  }
}

// class LoadingDialog {
//   BuildContext context;
//
//   LoadingDialog({required this.context});
//
//   show() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         return WillPopScope(
//           onWillPop: () async => Future.value(false),
//           child: const AlertDialog(
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 Text(
//                   'Loading data from server, please wait...',
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class ErrorHandler {
//   BuildContext context;
//   DioException dioExc;
//   bool? isLoginForm;
//
//   ErrorHandler({
//     required this.context,
//     required this.dioExc,
//     this.isLoginForm,
//   });
//
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       'https://www.googleapis.com/auth/contacts.readonly',
//     ],
//   );
//
//   void show() {
//     int? errCode;
//     String? serverErrMessage;
//     String? errMessage;
//
//     if(dioExc.response != null) {
//       errCode = dioExc.response!.statusCode;
//
//       if(dioExc.response!.data != null) {
//         if(dioExc.response!.data!['message'] != null) {
//           serverErrMessage = dioExc.response!.data!['message'];
//         }
//       }
//
//       switch(errCode) {
//         case 401:
//           if(serverErrMessage != null) {
//             errMessage = '(401) Unauthorized action. \n\n$serverErrMessage';
//           } else {
//             errMessage = '(401) Unauthorized action. Please try again!';
//           }
//           break;
//         case 404:
//           if(serverErrMessage != null) {
//             errMessage = '(404) Request not found. \n\n$serverErrMessage';
//           } else {
//             errMessage = '(404) Request not found. For more information, please contact administrator!';
//           }
//           break;
//         case 422:
//           if(serverErrMessage != null) {
//             errMessage = '(422) Invalid input request. ${'\n\n$serverErrMessage\n\n'}Please check all submitted data and try again!';
//           } else {
//             errMessage = '(422) Invalid input request. Please check all submitted data and try again!';
//           }
//           break;
//         case 500:
//           if(serverErrMessage != null) {
//             errMessage = '(500) Internal server error. \n\n$serverErrMessage';
//           } else {
//             errMessage = '(500) Internal server error. For more information, please contact administrator!';
//           }
//           break;
//         case 599:
//           if(serverErrMessage != null) {
//             errMessage = "(599) Unknown status. \n\n$serverErrMessage";
//           } else {
//             errMessage = "(599) Unknown status. Unable to access this menu because it's under maintenance. For more information, please contact administrator!";
//           }
//           break;
//         default:
//           if(serverErrMessage != null) {
//             errMessage = '${dioExc.response!.statusCode != null ? "(${dioExc.response!.statusCode!}) " : ""}Unknown error. \n\n$serverErrMessage';
//           } else {
//             errMessage = '${dioExc.response!.statusCode != null ? "(${dioExc.response!.statusCode!}) " : ""}Unknown error. For more information, please contact administrator!';
//           }
//           break;
//       }
//
//       OkDialog(
//         context: context,
//         content: errMessage,
//         headIcon: false,
//         okPressed: () async {
//           if(errCode == 401) {
//             await _googleSignIn.isSignedIn().then((isSignedIn) {
//               if(isSignedIn == true) {
//                 _googleSignIn.signOut();
//                 _googleSignIn.disconnect();
//               }
//             });
//
//             if(isLoginForm == null || isLoginForm == false) {
//               await LocalSharedPreferences.removeAllKey().then((deleteResult) {
//                 if(deleteResult == true) {
//                   RedirectTo(
//                     context: context,
//                     target: const SplashPage(),
//                   ).go();
//                 }
//               });
//             }
//           }
//         },
//       ).show();
//     }
//   }
// }