// import 'package:flutter/material.dart';
//
// class DemoPage extends StatefulWidget {
//   const DemoPage({Key? key}) : super(key: key);
//
//   @override
//   State<DemoPage> createState() => _DemoPageState();
// }
//
// class _DemoPageState extends State<DemoPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           ListTile(
//             title: Text(
//               (i + 1).toString() + ".     " + data[i]["question"],
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           RadioListTile(
//             title: Text(data[i]["option1"]),
//             groupValue: g[i],
//             value: 1,
//             onChanged: (int x) => c(x, i),
//           ),
//           RadioListTile(
//             title: Text(data[i]["option2"]),
//             groupValue: g[i],
//             value: 2,
//             onChanged: (int x) => c(x, i),
//           ),
//           data[i]["option3"] != ""
//               ? RadioListTile(
//             title: Text(data[i]["option3"]),
//             groupValue: g[i],
//             value: 3,
//             onChanged: (int x) => c(x, i),
//           )
//               : Container()
//         ],
//       ),
//     );
//   }
//   c(int x, int i) {
//     this.setState(() {
//       g[i] = x;
//       if (g.indexOf(0) == -1) {
//         submitVisible = true;
//       } else {
//         submitVisible = false;
//       }
//     });
//   }
// }
