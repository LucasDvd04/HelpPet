import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:helppet/model/UserDAO.dart';

class LoginFace {
  Map<String, dynamic> us = {};
  bool isLoggedIn = false;
  bool x = false;
  UsuarioDAO ud = new UsuarioDAO();

  tryLoginFacebook() async {
    await initiateFacebookLogin();
    print(isLoggedIn);
    print(us);
    x = await ud.inserirUserFacebook(us);
    return us;
  }

  initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logIn(['email', 'public_profile']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        isLoggedIn = false;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        isLoggedIn = false;
        break;

      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");

        FacebookAccessToken myToken = facebookLoginResult.accessToken;
        AuthCredential credential =
            FacebookAuthProvider.getCredential(accessToken: myToken.token);
        FirebaseUser firebaseUser =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;

        us['nome'] = firebaseUser.displayName;
        us['email'] = firebaseUser.email;
        us['login'] = firebaseUser.uid;
        isLoggedIn = true;

        break;
    }
  }
}
