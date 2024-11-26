import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Presentation/Screens/auth/Widgets/Custom_Field.dart';
import 'package:todo_app/core/utils/app_light_Styles.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';
import 'package:todo_app/core/utils/constant_Manager.dart';
import 'package:todo_app/core/utils/dialog_utils/dialog_utils.dart';
import 'package:todo_app/core/utils/email_Validation.dart';
import 'package:todo_app/core/utils/routes_Manager.dart';
import 'package:todo_app/dataBase_Manager/model/user_dm.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

 late TextEditingController fullNameController;
 late TextEditingController userNameController;
 late TextEditingController emailController;
 late TextEditingController passwordController;
 late TextEditingController rePasswordController;
GlobalKey<FormState> formKey =GlobalKey();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController =TextEditingController();
    userNameController =TextEditingController();
    emailController =TextEditingController();
    passwordController =TextEditingController();
    rePasswordController =TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('To Do',style: ApplightStyle.todoLogo,textAlign: TextAlign.center,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Full Name',style: ApplightStyle.title,),
                SizedBox(height: 12,),
                CustomField(
                    hintText: 'Enter your full name',
                    controller: fullNameController,
                    keyboardType: TextInputType.name,
                    validator: (input) {
                      if(input==null || input.trim().isEmpty){
                        return 'Please, Enter your full name';
                      }
                      return null;
                    },
                ),
                Text('User Name',style: ApplightStyle.title,),
                SizedBox(height: 12,),
                CustomField(
                  hintText: 'Enter your user name',
                  controller: userNameController,
                  keyboardType: TextInputType.name,
                  validator: (input) {
                    if(input==null || input.trim().isEmpty){
                      return 'Please, Enter your user name';
                    }
                    return null;
                  },
                ),
                Text('ُEmail',style: ApplightStyle.title,),
                SizedBox(height: 12,),
                CustomField(
                  hintText: 'Enter your email address',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (input) {
                    if(input==null || input.trim().isEmpty){
                      return 'Please, Enter your email address';
                    }
                    if(!isValidEmail(input)){
                      return 'Email bad format';
                    }
                    return null;
                  },
                ),
                Text('Password',style: ApplightStyle.title,),
                SizedBox(height: 12,),
                CustomField(
                  hintText: 'Enter your Password',
                  controller: passwordController,
                  isSecure: true,
                  keyboardType: TextInputType.name,
                  validator: (input) {
                    if(input==null || input.trim().isEmpty){
                      return 'Please, Enter your password';
                    }
                    return null;
                  },
                ),
                Text('re-Password',style: ApplightStyle.title,),
                SizedBox(height: 12,),
                CustomField(
                  hintText: 'Confirm your Password',
                  controller: rePasswordController,
                  keyboardType: TextInputType.name,
                  isSecure: true,
                  validator: (input) {
                    if(input==null || input.trim().isEmpty){
                      return 'Please, Confirm your Password';
                    }
                    if(input!=passwordController.text){
                      return 'password doesn\'t match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12,),
                MaterialButton(onPressed: () {
                  signUp();
                },
                  // padding: EdgeInsets.symmetric(vertical: 11,),
                color: ColorsManager.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                  child: Text('Sign-Up',style: ApplightStyle.buttonTitle,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',style: ApplightStyle.textButtonTitle?.copyWith(fontSize: 12,fontWeight: FontWeight.w400),),
                    TextButton(onPressed: () {
                      Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
                    }, child:Text('Sign-In',style: ApplightStyle.textButtonTitle?.copyWith(
                      decoration:TextDecoration.underline,
                    ),) ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async{
  if(formKey.currentState?.validate()==false)return;
    // create user
  try {
    DialogUtils.showLoading(context, message: 'Wait....');
  UserCredential credential = await FirebaseAuth.instance.
    createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  addUserToFireStore(credential.user!.uid);
  if(mounted){
    DialogUtils.hide(context);
  }
  DialogUtils.showMessage(context,body: 'User registrt Successfully',
  posActionTitle: 'ok',
    posAction: (){
    Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
    }
  );

  } on FirebaseAuthException catch (authError) {
    DialogUtils.hide(context);
   late String message;
    if (authError.code == ConstantManager.weekPassword) {
      message = 'The password provided is too weak.';
    } else if (authError.code == ConstantManager.emailAlreadyInUse) {
      message = 'The account already exists for that email.';
    }
    DialogUtils.showMessage(context,title: 'Error ',body: message,
    posActionTitle: 'Ok',
      // posAction: (){
      // Navigator.pop(context);
      // }
    );
  } catch (error) {
    DialogUtils.hide(context);
    DialogUtils.showMessage(context,title: 'Error Occured',body: error.toString(),);
  }
  }

  void addUserToFireStore(String uid) async{
    CollectionReference userCollectionReference = FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDocument = userCollectionReference.doc(uid);
    UserDM userDM = UserDM(id: uid, fullName: fullNameController.text, userName: userNameController.text, email: emailController.text);
    await userDocument.set(userDM.toFireStore());
  }
}
