import 'package:flutter/material.dart';
import '../../../../config/config.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSubmitted;
  final VoidCallback onTap;

  const SearchBar({Key? key, required this.onSubmitted, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          isDense: true,
          hintText: 'Search characters...',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: CustomColors.containerColor,
            size: 25,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
            },
            icon: InkWell(
              onTap: onTap,
              child: const Icon(
                Icons.refresh,
                size: 25,
                color: CustomColors.containerColor,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
