// import 'package:flutter/material.dart';
//
// class ContactNumber extends StatefulWidget {
//   final TextEditingController contactController;
//   final String initialContactNumber;
//   final Function(String) onContactNumberChanged;
//
//   const ContactNumber({
//     Key? key,
//     required this.contactController,
//     required this.initialContactNumber,
//     required this.onContactNumberChanged,
//   }) : super(key: key);
//
//   @override
//   _ContactNumberState createState() => _ContactNumberState();
// }
//
// class _ContactNumberState extends State<ContactNumber> {
//   bool _isNumberVisible = false; // Controls visibility of the contact number
//   late FocusNode _focusNode; // FocusNode to detect taps
//   late String _currentContactNumber; // Store current contact number state
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode()
//       ..addListener(() {
//         _onFocusChange(_focusNode.hasFocus); // Listen to focus changes
//       });
//     _currentContactNumber = widget.initialContactNumber; // Initialize with initial value
//   }
//
//   // Function to format the contact number with '*' for all digits when hidden
//   String _formatContactNumber(String number) {
//     if (!_isNumberVisible) {
//       return '*' * number.length;
//     }
//     return number;
//   }
//
//   // Function to handle focus loss on the TextField
//   void _onFocusChange(bool hasFocus) {
//     if (!hasFocus) {
//       setState(() {
//         widget.contactController.text = _formatContactNumber(_currentContactNumber);
//       });
//     }
//   }
//
//   // Validate input to ensure only 11 digits are allowed
//   void _onContactNumberChanged(String value) {
//     if (value.length == 11) {
//       setState(() {
//         _currentContactNumber = value; // Update the contact number when valid
//       });
//       widget.onContactNumberChanged(value); // Call the provided callback if valid
//     }
//   }
//
//   // Function to show confirmation dialog before clearing the contact number
//   Future<void> _showConfirmationDialog() async {
//     if (_currentContactNumber.length != 11) {
//       return; // If the number is not valid, do not show the dialog
//     }
//
//     bool? shouldClear = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Change Contact Number?'),
//           content: Text('Do you want to clear the current number and start again?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(true); // User selects Yes
//               },
//               child: Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(false); // User selects No
//               },
//               child: Text('No'),
//             ),
//           ],
//         );
//       },
//     );
//
//     if (shouldClear == true) {
//       setState(() {
//         _currentContactNumber = ''; // Clear the contact number in the state
//         widget.contactController.clear(); // Clear the TextField
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 350, // Maintain the same width as other widgets
//       child: TextField(
//         focusNode: _focusNode,
//         controller: widget.contactController,
//         onChanged: _onContactNumberChanged, // Validate and format contact number
//         keyboardType: TextInputType.number,
//         maxLength: 11, // Limit input to 11 digits
//         decoration: InputDecoration(
//           labelText: 'Contact Number',
//           border: const OutlineInputBorder(),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: widget.contactController.text.isNotEmpty
//                   ? Colors.green
//                   : Colors.blue, // If text is not empty, use green
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: widget.contactController.text.isNotEmpty
//                   ? Colors.green
//                   : Colors.grey, // If text is not empty, use green
//             ),
//           ),
//           suffixIcon: IconButton(
//             icon: Icon(_isNumberVisible ? Icons.visibility : Icons.visibility_off),
//             onPressed: () {
//               setState(() {
//                 _isNumberVisible = !_isNumberVisible; // Toggle visibility
//                 if (_isNumberVisible) {
//                   widget.contactController.text = _currentContactNumber; // Show unmasked number
//                 } else {
//                   widget.contactController.text = _formatContactNumber(_currentContactNumber); // Mask the number
//                 }
//               });
//
//               // Start a timer to automatically hide the number after 3 seconds
//               Future.delayed(const Duration(seconds: 3), () {
//                 setState(() {
//                   _isNumberVisible = false; // Hide the contact number
//                   widget.contactController.text = _formatContactNumber(_currentContactNumber); // Mask the contact number
//                 });
//               });
//             },
//           ),
//         ),
//         onTap: () {
//           // Show the dialog only if the field already contains a contact number and it's valid (11 digits)
//           if (_currentContactNumber.isNotEmpty && _currentContactNumber.length == 11) {
//             _showConfirmationDialog();
//           }
//         },
//       ),
//     );
//   }
// }
