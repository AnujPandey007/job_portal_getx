import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/company.dart';
import '../views/apply_bottom_sheet.dart';

class CompanyListItem extends StatelessWidget {
  final Company company;
  final bool isApplied;
  final VoidCallback onApply;

  const CompanyListItem({super.key, required this.company, required this.isApplied, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0, 1),
                blurRadius: 25,
                spreadRadius: 0
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isApplied ? Colors.green : Colors.blueAccent,
            backgroundImage: NetworkImage(company.imageUrl),
            radius: 23,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          style: ListTileStyle.list,
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          title: Text(company.name.capitalize ?? "", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
          subtitle: Text(company.description, overflow: TextOverflow.ellipsis),
          trailing: CircleAvatar(
            backgroundColor: isApplied ? Colors.green : const Color(0xff635ef4),
            radius: 15,
            child: const Icon(Icons.work, color: Colors.white, size: 12,),
          ),
          onTap: () {
            showSheet(context, company, isApplied);
          },
        ),
      ),
    );
  }

  void showSheet(BuildContext context, Company company, bool isApplied) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.grey.shade300.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height*0.7,
        maxHeight: MediaQuery.sizeOf(context).height*0.7,
      ),
      builder: (BuildContext context) {
        return ApplyBottomSheet(company: company, isApplied: isApplied);
      }
    ).then((result) {
      if (result == 'applied') {
        onApply();
      }
    });
  }
}
