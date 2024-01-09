import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double calculateFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return screenWidth / 30;
  }
  
  @override
  Widget build(BuildContext context) {
    double FontSize = calculateFontSize(context);
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SignUp'),
        ),
        body: Container( decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/zoro.jpg'),
              fit: BoxFit.cover, // You can adjust the BoxFit property as needed
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                         color: Color.fromARGB(255, 109, 2, 141),
                          fontSize: FontSize, fontWeight: FontWeight.bold),
                    )
                  ),
                ),
                SizedBox(height: 10.0),
                Container(child: Row(children: <Widget>[
                  Expanded(child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // Add your button's functionality here
                      print('Button Pressed');
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.person,size:50),
                        SizedBox(width: 8.0),
                        Text('Owner'),
                      ],
                    ),style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),padding: EdgeInsets.all(30.0),minimumSize: Size(100, 100)),
                  ),
                     ],
                        ), ),
                      Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // Add your button's functionality here
                      print('Button Pressed');
                    }
                    ,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.person , size: 50,),
                        SizedBox(width: 8.0),
                        Text('Crew Member'),
                      ],
                    ),style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),padding: EdgeInsets.all(30.0),minimumSize: Size(100, 100)), 
                  ),
                ],
              ),), 
            
                ],)), 
                SizedBox(height: 10.0),
                
                Expanded(child: TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                   border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                  prefixIcon: Icon(Icons.person), // Add the icon here
                ),
              ),),SizedBox(height: 10.0),
                
                Expanded(child: TextField(
                  keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                   border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                  prefixIcon: Icon(Icons.email), // Add the icon here
                ),
              ),),SizedBox(height: 10.0),
                
                Expanded(child: TextField(
                  keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone No.',
                   border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                  prefixIcon: Icon(Icons.phone_in_talk), // Add the icon here
                ),
              ),),SizedBox(height: 10.0),
                
                Expanded(child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText:  true,
                decoration: InputDecoration(
                  labelText: 'Password',
                   border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                  prefixIcon: Icon(Icons.lock), // Add the icon here
                ),
              ),),SizedBox(height: 10.0),
                
                Expanded(child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText:  true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                   border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                  prefixIcon: Icon(Icons.lock), // Add the icon here
                ),
              ),),SizedBox(height: 10,),Expanded(child:  Center(
                child: ElevatedButton(
                      onPressed: () {
                        // Add your button's functionality here
                        print('Button Pressed');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(width: 8.0),
                          Text('Submit',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),padding: EdgeInsets.all(30.0),minimumSize: Size(50, 50)),
                    ),
              ),)
              
              ],
              
            ),
          ),
        ),
      ),
    );
  }
}
