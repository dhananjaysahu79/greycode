import 'package:flutter/material.dart';



showSnackBar(String message, context){
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        elevation: 5,
        margin: EdgeInsets.all(8),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Text(message),
    )
  );
}

GlobalKey<State> _dialogKey = GlobalKey<State>();

showAlert(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        key: _dialogKey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          height:  350,
          child: Column(
            children: [
              Image.asset("assets/Images/modal.gif",fit: BoxFit.cover,),
              Text('UPLOADING...', 
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
      )
  );
}


Center showCircularProgress() {
  return Center(child: CircularProgressIndicator(
    strokeWidth: 3,
    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
    backgroundColor: Colors.white,
  ));
}