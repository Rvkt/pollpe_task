// import 'package:flutter/material.dart';
//
// import '../constants/app_constants.dart';
// import '../core/theme/app_palette.dart';
// import '../models/poll.dart';
// import '../models/question.dart';
//
// class QuestionTile extends StatefulWidget {
//   final List<Question> questionList;
//
//   const QuestionTile({super.key, required this.questionList});
//
//   @override
//   State<QuestionTile> createState() => _QuestionTileState();
// }
//
// class _QuestionTileState extends State<QuestionTile> {
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context);
//     double width = ScreenUtil.screenWidth;
//     double height = ScreenUtil.screenHeight;
//     return SizedBox(
//       width: width,
//       child: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Questions',
//               style: TextStyle(
//                 fontFamily: 'VarelaRound',
//                 fontSize: 20,
//                 color: AppPalette.accentColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           widget.questionList.isEmpty
//               ? Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       'No questions yet. Add your first question!',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade600,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 )
//               : Expanded(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: widget.questionList.length,
//                     itemBuilder: (context, index) {
//                       final question = widget.questionList[index];
//                       return Card(
//                         margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         child: Theme(
//                           data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//                           child: ExpansionTile(
//                             title: Text(
//                               question.questionText,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                             children: [
//                               // Horizontal ListView.builder for options
//                               Container(
//                                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                                 height: 48, // Adjust height as needed
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: question.options.length,
//                                   padding: const EdgeInsets.symmetric(horizontal: 4),
//                                   itemBuilder: (context, index) {
//                                     final option = question.options[index];
//                                     return Padding(
//                                       padding: const EdgeInsets.only(right: 8.0),
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey.shade50, // Option button color
//                                           borderRadius: BorderRadius.circular(8),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             option,
//                                             style: const TextStyle(color: AppPalette.accentColor, fontSize: 12, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
