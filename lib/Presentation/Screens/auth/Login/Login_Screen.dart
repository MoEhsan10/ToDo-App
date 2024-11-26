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

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

 late TextEditingController emailController;
 late TextEditingController passwordController;

GlobalKey<FormState> formKey =GlobalKey();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController =TextEditingController();
    passwordController =TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                Text('ُEmail',style: ApplightStyle.title,),
                SizedBox(height: 8,),
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
                SizedBox(height: 8,),
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
                SizedBox(height: 12,),
                MaterialButton(onPressed: () {
                  signIn();
                },
                  // padding: EdgeInsets.symmetric(vertical: 11,),
                color: ColorsManager.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                  child: Text('Sign-in',style: ApplightStyle.buttonTitle,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('don\'t have an account?',style: ApplightStyle.textButtonTitle?.copyWith(fontSize: 12,fontWeight: FontWeight.w400),),
                    TextButton(onPressed: () {
                      Navigator.pushReplacementNamed(context, RoutesManager.registerRoute);
                    }, child:Text('Sign-Up',style: ApplightStyle.textButtonTitle?.copyWith(
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

 void signIn() async{
   if(formKey.currentState?.validate()==false)return;
   // create user
   try {
     DialogUtils.showLoading(context, message: 'Wait....');
     UserCredential credential = await FirebaseAuth.instance.
     signInWithEmailAndPassword(
       email: emailController.text,
       password: passwordController.text,
     );
     UserDM.currentUser =await readUsersFromForeStore(credential.user!.uid);
     if(mounted){
       DialogUtils.hide(context);
     }
     DialogUtils.showMessage(context,body: 'User Logged in Successfully',
         posActionTitle: 'ok',
         posAction: (){
           Navigator.pushReplacementNamed(context, RoutesManager.homeRoute);
         }
     );

   } on FirebaseAuthException catch (authError) {
     DialogUtils.hide(context);
     late String message;
     if (authError.code == ConstantManager.invalidCredential) {
       message = 'Wrong email or password';
     }

     DialogUtils.showMessage(context,title: 'Error ',body: message,
       posActionTitle: 'Ok',

     );
   } catch (error) {
     DialogUtils.hide(context);
     DialogUtils.showMessage(context,title: 'Error Occured',body: error.toString(),);
   }
 }

Future<UserDM> readUsersFromForeStore(String uid)async{
 CollectionReference userCollection = FirebaseFirestore.instance.collection(UserDM.collectionName);
 DocumentReference userDoc = userCollection.doc(uid);
 DocumentSnapshot userDocSnapShot =await userDoc.get();
 Map<String,dynamic> json = userDocSnapShot.data() as Map<String,dynamic>;
 UserDM userDM = UserDM.fromFireStore(json);
 return userDM;
}
}
