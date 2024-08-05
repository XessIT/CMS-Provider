import 'package:cms_provider/service_provider/screens/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms_provider/service_provider/bloc/register/register_bloc.dart';
import 'package:cms_provider/service_provider/bloc/register/register_state.dart';
import 'package:cms_provider/service_provider/bloc/register/register_event.dart'; // Import RegisterEvent

class RegisterScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF22538D), // Corrected color format
      body: BlocProvider(
        create: (context) => RegisterBloc(),
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Welcome Back !',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.80, // Adjust height based on screen height
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: screenHeight * 0.05),
                          const Text('Sign Up', style: TextStyle(fontSize: 24,)),

                          SizedBox(
                            child: Column(
                              children: [
                                SizedBox(height: screenHeight * 0.05),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: firstNameController,
                                    decoration: const InputDecoration(
                                      labelText: 'First Name',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.person, color: Color(0xFF22538D),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: lastNameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Last Name',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.person, color: Color(0xFF22538D),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: addressController,
                                    maxLength: 200,
                                    decoration: const InputDecoration(
                                      labelText: 'Address',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.location_on, color: Color(0xFF22538D),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: mobileController,
                                    decoration: const InputDecoration(
                                      labelText: 'Mobile Number',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.phone_android, color: Color(0xFF22538D),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: otpController,
                                    decoration: InputDecoration(
                                      labelText: 'OTP',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.password, color: Color(0xFF22538D),),
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.phonelink_lock, color: Color(0xFF22538D),),
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                BlocConsumer<RegisterBloc, RegisterState>(
                                  listener: (context, state) {

                                    if (state is RegisterFailure) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                                    } else if (state is RegisterSuccess) {
                                      // Navigate to home screen
                                      //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Categories(
                                      //      //welcomeMessage: 'Welcome to CMS, where your convenience is our commitment!'
                                      //  )));
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is RegisterLoading) {
                                      return CircularProgressIndicator();
                                    }

                                    return Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Text(
                                            "15 days free trial",
                                            style: TextStyle(color: Colors.green, fontSize: 16),
                                          ),
                                        ),

                                      ],
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: MaterialButton(
                                      color: Color(0xFF22538D),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Categories(
                                          //welcomeMessage: 'Welcome to CMS, where your convenience is our commitment!'
                                        )));
                                        BlocProvider.of<RegisterBloc>(context).add(
                                          RegisterButtonPressed(
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            address: addressController.text,
                                            mobile: mobileController.text,
                                            otp: otpController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                      },
                                      child: Text('REGISTER', style: TextStyle(color: Colors.white, fontSize: 18)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
