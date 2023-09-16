import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:golden_eyes/widgets/colors.dart';

class CopyWidget extends StatelessWidget {
  final String ticket;
  const CopyWidget({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      decoration: BoxDecoration(
        color: COLOR_BROWN,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: ListTile(
          title: Text(
            ticket,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: ticket)).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Copiado para área de transferência.')));
              });
            },
            icon: const FaIcon(
              FontAwesomeIcons.copy,
              color: COLOR_YELLOW,
            ),
          ),
        ),
      ),
    );
  }
}
