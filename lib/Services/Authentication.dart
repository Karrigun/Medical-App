import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_app/Models/User.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance ;

  User _userFromFireBaseUser(FirebaseUser user){
    return user != null ? User(uid : user.uid) : null ;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFireBaseUser(user));
  }
 //Sign in anon
  Future SignInAnon() async{
    try{
      AuthResult result  = await _auth.signInAnonymously();
      FirebaseUser user = result.user ;
      return _userFromFireBaseUser(user);
    }catch(ex){
      print(ex.toString());
      return null ;
    }
  }
  // Sign In awith the Email and Password
  Future signInWithEmailAndPassword(String email ,String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);
      FirebaseUser user = result.user ;
      return _userFromFireBaseUser(user);
    }catch(ex){

      print("hhgfhfh  " + ex.toString());
      return null ;
    }
  }

  // Register with the Email and Password .
  Future registerWithEmailAndPassword(String email ,String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email : email , password: password) ;
      FirebaseUser user = result.user ;
      return _userFromFireBaseUser(user);
    }catch(ex){
      print(ex.toString());
      return null ;
    }
  }

  // Sign out
  Future signOut() async{
    try{
      return await _auth.signOut() ;
    }catch(ex){
      print(ex.toString());
      return null ;
    }
  }


}