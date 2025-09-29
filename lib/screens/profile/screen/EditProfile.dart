import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController bioCtrl = TextEditingController();

  final FocusNode usernameNode = FocusNode();
  final FocusNode bioNode = FocusNode();
  final FocusNode nameNode = FocusNode();


  String selectedGender = "Male";



  addUserInfo() async {
    nameCtrl.text.trim();



    //
    // await Supabase.instance.client.from('Users').insert({
    //   'profileImg': ImageUrlCtrl.text.trim(),
    //   'name': nameCtrl.text.trim(),
    //   'username': usernameCtrl.text.trim(),
    //   'gender': gender.text.trim(),
    //   'bio': bioCtrl.text.trim(),
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8f8f8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf8f8f8),
        elevation: 0,
        automaticallyImplyLeading: false, // Prevents default back button
        title: Row(
          children: [
            // Back Button
            GestureDetector(
              onTap: ()async{
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

            const Spacer(), // Pushes the title to the center
            // Title
            const Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const Spacer(), // Balances the row
            // Notification Icon
            GestureDetector(
              onTap: (){
                addUserInfo();
                Navigator.pop(context);
                // Button click logic
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Profile Successfully Updated")),
                );
              },
              child: Text(
                "Done",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          /// Profile photo section
          SizedBox(
            width: double.infinity,
            height: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                      "https://preview.redd.it/umvub4tgwxt61.jpg?auto=webp&s=92f15de309c9701dfa14e7922072aa3bf0061746",
                      width: 115,
                      height: 115,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Change Profile Photo",
                  style: TextStyle(
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          Divider(thickness: 1, color: Colors.grey.shade300),
          const SizedBox(height: 5),

          /// Form fields
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputRow(
                  label: "Name",
                  hint: "Enter your name",
                  controller: nameCtrl,
                  focusNode: nameNode,
                  nextFocus: usernameNode,
                ),
                const SizedBox(height: 8),

                InputRow(
                  label: "Username",
                  hint: "Enter your username",
                  controller: usernameCtrl,
                  focusNode: usernameNode,
                  nextFocus: bioNode,
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Text(
                      "Gender",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 90,),

                    ChoiceChip(
                      label: Text("Male"),
                      selected: selectedGender == "Male",
                      onSelected: (bool selected) {
                        setState(() {
                          selectedGender = "Male";
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    ChoiceChip(
                      label: Text("Female"),
                      selected: selectedGender == "Female",
                      onSelected: (bool selected) {
                        setState(() {
                          selectedGender = "Female";
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                InputRow(
                  label: "Bio",
                  hint: "Tell us a little about yourself",
                  controller: bioCtrl,
                  focusNode: bioNode,
                  nextFocus: null, // last field
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}



class InputRow extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  const InputRow({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.focusNode,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: const TextStyle(fontSize: 16),
            textInputAction: nextFocus != null
                ? TextInputAction.next
                : TextInputAction.done,
            onEditingComplete: () {
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              } else {
                FocusScope.of(context).unfocus();
              }
            },
            keyboardType: TextInputType.text,
            autocorrect: true,
            enableSuggestions: true,
            cursorColor: Colors.blue,
            onChanged: (value) {
              // Could add debounce here
            },
            onSubmitted: (value) {
              debugPrint("Submitted $label: $value");
            },
          ),
        ),
      ],
    );
  }
}