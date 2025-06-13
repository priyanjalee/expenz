import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/screens/main_screen.dart';
import 'package:expenz/screens/user_service.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  //for the check box
  bool _rememberMe=false;

  //form key for the form validation
  final _formKey = GlobalKey<FormState>();

  //controllers from the text from fields
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: SingleChildScrollView(
      child: SafeArea(child: Padding(
        padding: const EdgeInsets.all(kDefaultpadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter Your \nPersonal Details",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30,),
              //Form
              Form(
                key: _formKey,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //form field for the user name
                  TextFormField(
                    controller: _userNameController,
                    validator: (value) {
                      //check weather the user enter valid user name
                      if(value!.isEmpty){
                        return "Please Enter your name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,horizontal: 20
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  //form field for the email
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      //check weather the user enter valid email
                      if(value!.isEmpty){
                        return "Please Enter your Email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,horizontal: 20
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  //form field for the password
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      //check weather the user enter valid password
                      if(value!.isEmpty){
                        return "Please Enter your password";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,horizontal: 20
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  //form field for the confirm password
                  TextFormField(
                    controller: _confirmPasswordController,
                    validator: (value) {
                      //check weather the user confirm password
                      if(value!.isEmpty){
                        return "Please confirm password";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: " Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,horizontal: 20
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  //remember me for the next time
                  Row(
                    children: [const Text("Remember me for the next time",
                    style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w500,
                      color: kGrey,
                    ),
                    ),
                    Expanded(child: CheckboxListTile(
                      activeColor: kMainColor,
                      value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe=value!;
                      },);
                      
                    },),),
                    

                    ],
                  ),
                  const SizedBox(
                      height: 30,
                    ),
                    //submit button
                    GestureDetector(
                      onTap: () async {
                        if(_formKey.currentState!.validate()){
                          //form is valid ,process data
                          String userName=_userNameController.text;
                          String email=_emailController.text;
                          String password=_passwordController.text;
                          String confirmPassword=_confirmPasswordController.text;

                          //save the user name and email in the device storage

                          await UserService.storeUserDetails(
                            userName=userName,
                            email=email,
                            password=password,
                            confirmPassword=confirmPassword,
                            context=context,

                          );
                          //navigation to the main screen
                          if(context.mounted){
                             Navigator.push(context, MaterialPageRoute(builder: (context){
                            return const MainScreen();
                          },
                         
                          ),);
                        }
                      };
                      child: const CustomButton(
                        buttonName: "Next", buttonColor: kMainColor);},
                    ),


                ],
              ),),
          ],
        ),
      )),
     ),
    );
  }
}