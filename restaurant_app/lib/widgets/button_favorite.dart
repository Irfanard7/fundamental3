import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  final toast = FToast();

  @override
  void initState() {
    super.initState();

    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
        size: 27,
      ),
      onPressed: () {
        !isFavorite
            ? showToastMessage("Berhasil ditambahkan ke Favorit!")
            : showToastMessage("Favorit berhasil dihapus!");
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }

  void showToastMessage(String message) {
    toast.showToast(child: _buildToast(message), gravity: ToastGravity.BOTTOM);
  }

  Widget _buildToast(message) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
