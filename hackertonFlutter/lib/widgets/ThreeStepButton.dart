import 'package:flutter/material.dart';
import 'package:untitled3/signUp.dart';

class ThreeStepButton extends StatefulWidget {
  final int value;
  final ValueChanged<int>? onChanged;
  final String label;

  ThreeStepButton({required this.value, this.onChanged, required this.label});

  @override
  _ThreeStepButtonState createState() => _ThreeStepButtonState();
}

class _ThreeStepButtonState extends State<ThreeStepButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black
          ),
        ),
        SizedBox(width: 100),
        ...List.generate(
          3,
              (index) => GestureDetector(
            onTap: () {
              if (widget.onChanged != null) {
                widget.onChanged!(index + 1);//여기서 어떤 버튼 클릭됐는지 알 수 있음
                print(index+1);
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: widget.value == index + 1 ? myColor3 : myColor1,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: widget.value == index + 1 ? Colors.white : myColor4,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
