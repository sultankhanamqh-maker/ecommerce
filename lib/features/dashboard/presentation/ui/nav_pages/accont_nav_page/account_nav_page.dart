import 'package:ecommerce/core/app_routes/app_routes.dart';
import 'package:ecommerce/core/constants/app_colors.dart';
import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/profile/profile_bloc.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/profile/profile_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../bloc/profile/profile_state.dart';

class AccountNavPage extends StatefulWidget {
  const AccountNavPage({super.key});

  @override
  State<AccountNavPage> createState() => _AccountNavPageState();
}

class _AccountNavPageState extends State<AccountNavPage> {

  List<Map<String,dynamic>>  profileList = [
    {
      "name" : "My Cart",
      "icon" : Icons.shopping_cart,
    },
    {
      "name": "My Orders",
      "icon": Icons.shopping_bag,
    },
    {
      "name": "Log Out",
      "icon": Icons.logout,
    },

    ];

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyAppColor,
         appBar: AppBar(
           backgroundColor: AppColors.greyAppColor,
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<ProfileBloc,ProfileState>(
            builder: (context,state){
              if(state is ProfileLoadingState){
                return Center(child: CircularProgressIndicator());
              }
              if(state is ProfileErrorState){
                return Center(child: Text(state.errorMsg));
              }
              if(state is ProfileLoadedState){

                var data = state.allProfile;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.greyAppColor,
                    radius: 30,
                    child: Center(child: Icon(Icons.person,color: Colors.grey,size: 50,),),
                  ),
                  title: Text(data.name ?? "",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20 ),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email : ${data.email}",style: TextStyle(fontWeight: FontWeight.bold,fontSize:17,color: Colors.grey ),),
                      Text("Mobile No : ${data.mobileNumber}",style: TextStyle(fontWeight: FontWeight.bold,fontSize:17 ,color: Colors.grey),)
                    ],
                  ),
                );
              }
              return Container();

            }
          ),
          Expanded(
            child: ListView.builder(
              itemCount: profileList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_,index){
              return ListTile(
                onTap: ()async {
                  if (index == 2) {
                    SharedPreferences prefs = await SharedPreferences
                        .getInstance();
                    prefs.setString(AppConstants.tokenLoginKey, "");
                    if (mounted) {
                      Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
                    }
                  }
                  if(index == 0){
                    Navigator.pushNamed(context, AppRoutes.cartNavPage);
                  }
                  if(index == 1){
                    Navigator.pushNamed(context, AppRoutes.orderPage);
                  }
                },
                leading: Icon(profileList[index]["icon"],),
                title: Text(profileList[index]["name"],style: TextStyle(fontWeight: FontWeight.bold),),
              );
            }),
          )

        ],
      ),
    );
  }
}
