import 'package:flutter/cupertino.dart';
import 'package:pokegendra/utils/utils.dart';

Widget titleText(text) {
  return Text(
    capitalize(text),
    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  );
}

Widget subtitleText(text) {
  return Text(
    capitalize(text),
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  );
}

Widget normalText(text) {
  return Text(
    capitalize(text),
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  );
}

Widget doubleNormalText(text1, text2) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: text1,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        TextSpan(
          text: text2,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    ),
  );
}
