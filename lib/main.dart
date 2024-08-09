import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app1/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyB1K-xpDJFpIMhMUbJra0Qt4E_HDAgyhWQ',
        appId: 'appId',
        messagingSenderId: 'messagingSenderId',
        projectId: 'signupproject-6d9f0'),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login and Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginSignUpPage(),
    );
  }
}

class LoginSignUpPage extends StatefulWidget {
  @override
  _LoginSignUpPageState createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.green, Colors.blue]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.red,
                  indicatorWeight: 5,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white54,
                  tabs: [
                    Tab(text: "Sign Up"),
                    Tab(text: "Sign In"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                SignUpForm(),
                SignInForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String? name, email, password;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            "Create An Account",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Full Name",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value1) {
              name = value1;
            },
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value2) {
              email = value2;
            },
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.lock),
              suffixIcon: Icon(Icons.visibility_off),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value3) {
              password = value3;
            },
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email!, password: password!);
                if (newUser != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInForm(),
                    ),
                  );
                }
              } catch (e) {
                print(e);
              }
            },
            child: Text(
              "Sign Up",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
          SizedBox(height: 20),
          Center(child: Text("Or sign up with")),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.account_circle_sharp),
                color: Colors.red,
                iconSize: 40,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.facebook),
                color: Colors.blue,
                iconSize: 40,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  String? email, password;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            "Welcome Back!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              email = value;
            },
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.lock),
              suffixIcon: Icon(Icons.visibility_off),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              password = value;
            },
            obscureText: true,
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text("Remember Password"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                final user = await _auth.signInWithEmailAndPassword(
                    email: email!, password: password!);
                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                }
              } catch (e) {
                print(e);
              }
            },
            child: Text("Sign In"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
          SizedBox(height: 20),
          Center(child: Text("Or sign in with")),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.g_translate),
                color: Colors.red,
                iconSize: 40,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.facebook),
                color: Colors.blue,
                iconSize: 40,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}



