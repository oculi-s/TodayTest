import 'package:flutter/material.dart';

class CustomRadioComponent extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onSelect;

  const CustomRadioComponent({
    Key? key,
    required this.title,
    required this.onSelect,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onSelect,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 26,
          ),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).highlightColor : Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Theme.of(context).highlightColor,
            ),
          ),
          child: Row(
            children: [
              isSelected
                  ? Container(
                      height: 24,
                      width: 24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
              const SizedBox(
                width: 16,
              ),
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
