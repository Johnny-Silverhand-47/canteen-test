import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {Key? key,
      this.controller,
      this.focusNode,
      this.titleText = '',
      this.hPadding = 0,
      this.vPadding = 0,
      this.hintText,
      this.labelText,
      this.obscureText = false,
      this.readOnly = false,
      this.suffix,
      this.prefix,
      this.validator,
      this.filled = false,
      this.keyboardType,
      this.onTap,
      this.onChanged,
      this.onSaved,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSuffixTap,
      this.onPrefixTap,
      this.autoFocus = false,
      this.maxLines = 1,
      this.minLine = 1,
      this.initialValue,
      this.isWhite = false,
      this.topContentPadding = 14,
      this.bottomContentPadding = 14,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w600})
      : super(key: key);
  final TextEditingController? controller;
  final double vPadding;
  final double hPadding;
  final String? hintText;
  final String? labelText;
  final FocusNode? focusNode;
  final String titleText;
  final bool readOnly;
  final bool obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final GestureTapCallback? onSuffixTap;
  final GestureTapCallback? onPrefixTap;
  final Function()? onTap;
  final Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool filled;
  final bool autoFocus;
  final int maxLines;
  final int minLine;
  final String? initialValue;
  final bool isWhite;
  final double topContentPadding;
  final double bottomContentPadding;
  final double fontSize;
  final FontWeight fontWeight;

  //--------------------------Theme--------------------------------

  final textFieldBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: AppColors.underline),
  );

//------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall!.copyWith(
          color: isWhite ? AppColors.white : AppColors.text,
          fontSize: fontSize,
          fontWeight: fontWeight,
        );

    final hintStyle = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: isWhite ? AppColors.white : AppColors.label,
        );
    final cursorColor = isWhite ? AppColors.underline : AppColors.primary;

    return Padding(
      padding: EdgeInsets.fromLTRB(hPadding, vPadding, hPadding, 0),
      child: TextFormField(
        style: textStyle,
        cursorColor: cursorColor,
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        obscuringCharacter: '*',
        keyboardType: keyboardType,
        readOnly: readOnly,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        autofocus: autoFocus,
        maxLines: maxLines,
        minLines: minLine,
        initialValue: initialValue,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              top: topContentPadding, bottom: bottomContentPadding),
          border: textFieldBorder,
          enabledBorder: textFieldBorder,
          errorBorder: textFieldBorder.copyWith(
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: textFieldBorder,
          filled: filled,
          isDense: true,
          hintText: hintText,
          hintStyle: hintStyle,
          labelText: labelText,
          labelStyle: hintStyle,
          prefixIcon: prefix != null
              ? GestureDetector(
                  onTap: onPrefixTap,
                  child: prefix,
                )
              : null,
          suffixIcon: suffix != null
              ? GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onSuffixTap,
                  child: suffix,
                )
              : null,
        ),
      ),
    );
  }
}
