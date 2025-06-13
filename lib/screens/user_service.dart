import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  //check weather the user entered name and email in shared pref
  static Future<void>storeUserDetails(
    String userName,String email,String password,String confirmPassword,BuildContext context
  )async{
    
  try{
    //check weather the user entered password and the confirm password are the same
  if(password!=confirmPassword){
    //show a message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Password and confirm password do not match"),),

    );
    return;
  }
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setString("userName", userName);
    await prefs.setString("email", email);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:Text("User details stroed successfully")));

  }catch(err){
    err.toString();
  }
  }
}