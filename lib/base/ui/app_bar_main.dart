// import 'package:flutter/material.dart';
//
// import '../../../main.dart';
// import 'appbar_background_decoration.dart';
//
// class AppbarMain extends PreferredSize {
//   String? title;
//   bool isVisibilityBackIcon = false;
//   Icon? iconAction;
//   Function()? onClickAction;
//   Function()? onBackPress;
//
//   AppbarMain({
//     @required this.title,
//     this.isVisibilityBackIcon = true,
//     this.iconAction,
//     this.onClickAction,
//     this.onBackPress
//   }) : super(
//     child: child,
//     preferredSize: preferredSize
//   );
//
//   @override
//   Size get preferredSize {
//     return Size.fromHeight(50);
//   }
//
//
//   @override
//   Widget get _child {
//     return Stack(
//       children: [
//         Container(
//           height: 90,
//           width: double.infinity,
//           decoration: AppbarBackgroundDecoration(),
//           alignment: Alignment.center,
//           padding: EdgeInsets.only(
//             top: MediaQuery.of(mainGlobalKey!.currentContext!).padding.top,
//           ),
//           child: Text(
//             "$title",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18
//             ),
//           ),
//         ),
//         Visibility(
//           visible: isVisibilityBackIcon,
//           child: Container(
//             alignment: Alignment.centerLeft,
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(mainGlobalKey!.currentContext!).padding.top,
//               left: 16
//             ),
//             child: InkWell(
//               child: Icon(Icons.arrow_back, color: Colors.white, size: 24,),
//               onTap: () {
//                 if (onBackPress == null) {
//                   Navigator.pop(mainGlobalKey!.currentContext!);
//                 } else {
//                 }
//               },
//             ),
//           ),
//         ),
//         Visibility(
//           visible: iconAction != null,
//           child: Container(
//             alignment: Alignment.centerRight,
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(mainGlobalKey!.currentContext!).padding.top,
//               right: 16
//             ),
//             child: InkWell(
//               child: iconAction,
//               onTap: () {
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
