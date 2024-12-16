import 'package:flutter/material.dart';

class ContactNumber extends StatefulWidget {
  final TextEditingController contactController;
  final String initialContactNumber;
  final Function(String) onContactNumberChanged;

  const ContactNumber({
    Key? key,
    required this.contactController,
    required this.initialContactNumber,
    required this.onContactNumberChanged,
  }) : super(key: key);

  @override
  _ContactNumberState createState() => _ContactNumberState();
}

class _ContactNumberState extends State<ContactNumber> {
  bool _isNumberVisible = false; // Controls visibility of the contact number

  // Function to format the contact number with '*' for all digits when hidden
  String _formatContactNumber(String number) {
    if (!_isNumberVisible) {
      return '*' * number.length;
    }
    return number;
  }

  // Function to handle focus loss on the TextField
  void _onFocusChange(bool hasFocus) {
    if (!hasFocus) {
      setState(() {
        widget.contactController.text = _formatContactNumber(widget.initialContactNumber);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350, // Maintain the same width as other widgets
      child: Focus(
        onFocusChange: _onFocusChange, // Trigger on focus loss
        child: TextField(
          controller: widget.contactController,
          onChanged: widget.onContactNumberChanged, // Validate and format contact number
          keyboardType: TextInputType.number,
          maxLength: 11, // Limit input to 11 digits
          decoration: InputDecoration(
            labelText: 'Contact Number',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(_isNumberVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isNumberVisible = true; // Make the contact number visible
                  widget.contactController.text = widget.initialContactNumber; // Show the unmasked contact number
                });

                // Start a timer to automatically hide the number after 3 seconds
                Future.delayed(const Duration(seconds: 3), () {
                  setState(() {
                    _isNumberVisible = false; // Hide the contact number
                    widget.contactController.text = _formatContactNumber(widget.initialContactNumber); // Mask the contact number
                  });
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
