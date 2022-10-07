import 'package:flutter/material.dart';
import '../../../../config/config.dart';

class SearchBar extends StatelessWidget {
  final Function(String)? onSubmitted;
  final Function(String)? onFilter;
  final VoidCallback? onTap;
  final VoidCallback? onTapFilter;
  final TextEditingController? controller;

  const SearchBar(
      {Key? key,
      required this.onSubmitted,
      required this.onTapFilter,
      required this.onTap,
      required this.onFilter,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        onChanged: onFilter,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          isDense: true,
          hintText: 'Search characters...',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
          prefixIcon: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
            },
            icon: InkWell(
              onTap: onTapFilter,
              child: const Icon(
                Icons.search,
                size: 25,
                color: AppThemeLight.primaryColor,
              ),
            ),
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
                color: AppThemeLight.primaryColor,
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
