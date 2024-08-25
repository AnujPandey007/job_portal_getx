import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/models/company.dart';

class ApplyBottomSheet extends StatelessWidget {
  final Company company;
  final bool isApplied;

  const ApplyBottomSheet({super.key, required this.company, required this.isApplied});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -50,
          left: 30,
          child: Container(
            height: 120,
            width: 120,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            child: const Center(
              child: CircleAvatar(
                backgroundColor: Color(0xfff4f4f4),
                radius: 45,
                child: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 25,
                  backgroundImage: NetworkImage(
                    "https://cdn2.hubspot.net/hubfs/53/image8-2.jpg"
                  ),
                ),
              ),
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Google LLC",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text("Silicon Valley, CA", style: TextStyle(color: Colors.grey, fontSize: 13),),
              const SizedBox(height: 16),
              const Text("Tech based company and the producer", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),),
              const SizedBox(height: 64),
              const Text("Job Role", style: TextStyle(color: Colors.grey, fontSize: 13),),
              const SizedBox(height: 8),
              const Text("Senior UI/UX Designer", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),),
              const SizedBox(height: 45),
              const Text("Qualification", style: TextStyle(color: Colors.grey, fontSize: 13)),
              const Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    "Applicants must have at least up to 10 years of design experience and must be familiar with some design technologies such as figma.",
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600, height: 3),),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 45,
                decoration: BoxDecoration(
                  color: isApplied ? Colors.green : const Color(0xff635ef4),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white60,
                        offset: Offset(0, 1),
                        blurRadius: 10,
                        spreadRadius: 50
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: (){
                    if (isApplied) {
                      Get.snackbar('Notice', 'Job already applied');
                      Navigator.pop(context);
                    }else{
                      Navigator.pop(context, 'applied');
                    }
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Ink(
                    width: MediaQuery.sizeOf(context).width,
                    height: 45,
                    decoration: BoxDecoration(
                      color: isApplied ? Colors.green : const Color(0xff635ef4),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: isApplied ? Colors.green : const Color(0xff635ef4).withOpacity(0.5),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                            spreadRadius: 5
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Center(child: Text(isApplied ? "ALREADY APPLIED" : 'APPLY NOW', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
