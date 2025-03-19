import 'package:flutter/material.dart';

class RememberMeCheckbox extends StatefulWidget {
  final ValueChanged<bool?>? onChanged;

  const RememberMeCheckbox({super.key, this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _RememberMeCheckboxState createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(isChecked);
            }
          },
        ),
        const Text("Remember me"),
      ],
    );
  }
}
