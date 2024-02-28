import 'package:expense_tracker6/register.dart';
import 'package:expense_tracker6/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var userName = '';
//import 'Register.dart';
//import 'add.dart';

//import 'chart.dart';
//import 'export.dart';
//import 'rateus.dart';
//import 'settings.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    getUser();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = new TextEditingController();
  @override
  showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(6.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Write a category',
                              labelText: 'Category',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            onChanged: (String driverNIC) {}),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Write a description',
                              labelText: 'Description',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            onChanged: (String policeNIC) {}),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Add the amount',
                              labelText: 'Amount',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            onChanged: (String phnumber) {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          child: Text("Submit"),
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                            });
                            Navigator.of(context).pop();
                            ;
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  showaboutDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {},
                // padding:const EdgeInsets.all(15),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue.shade400),
                ),
                child: const Text(
                  'Dismiss',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              )
            ],
            title: Text('About Us'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('Our app will help you to manage all your expenses'),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash Expense'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black45, Colors.blue],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('shalini '),
            
            accountEmail: Text('shalinisubodha07@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black45, Colors.blue],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              //color: Colors.blue,
              /*image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')
                ),*/
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Charts'),
            onTap: () {
              /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => chartScreen()),
                );*/
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_upload_outlined),
            title: const Text('Export'),
            onTap: () {
              /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => exportScreen()),);*/
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_rate),
            title: const Text('Rate Us'),
            onTap: () {
              /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => rateScreen()),);*/
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => settingsScreen ()),);*/
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('About US'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => showFormDialog(context)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.more_horiz),
            title: const Text('Sign Out'),
            onTap: () => {
              //sign out
              signOut()
            },
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddScreen()
                  ),);*/
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  Future getUser() async {
    if (_auth.currentUser != null) {
      var cellNumber = _auth.currentUser!.phoneNumber;
      cellNumber =
          '0' + _auth.currentUser!.phoneNumber!.substring(3, cellNumber!.length);
      debugPrint(cellNumber);
      await _firestore
          .collection('users')
          .where('cellnumber', isEqualTo: cellNumber)
          .get()
          .then((result) {
        if (result.docs.length > 0) {
          setState(() {
            userName = result.docs[0].data()['name'];
          });
        }
      });
    }
  }


  signOut() {
    //redirect
    _auth.signOut().then((value) => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen())));
  }
}
