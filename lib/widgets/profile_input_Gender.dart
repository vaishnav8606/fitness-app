// import 'package:flutter/material.dart';

// class ProfileInputGender extends StatelessWidget {
//   const ProfileInputGender({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           const Expanded(
//             flex: 1,
//             child: Text(
//               'Gender',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: DropdownButtonFormField<String>(
//               value: _selectedGender,
//               style: const TextStyle(color: Colors.white),
//               decoration: const InputDecoration(
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide:
//                       BorderSide(color: Color.fromARGB(255, 26, 198, 195)),
//                 ),
//               ),
//               dropdownColor: Colors.black,
//               items: ['male', 'female']
//                   .map((label) => DropdownMenuItem(
//                         value: label,
//                         child: Text(
//                           label,
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedGender = value;
//                 });
//               },
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please select gender';
//                 }
//                 return null;
//               },
//             ),
//           ),
//         ],
//       ),
//     );
  
// }
// }
    

