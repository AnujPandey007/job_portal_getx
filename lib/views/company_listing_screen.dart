import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/company_controller.dart';
import '../widgets/company_list_item.dart';

class CompanyListingScreen extends StatelessWidget {
  final CompanyController companyController = Get.put(CompanyController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!companyController.isDataLoaded.value) {
        return Container(color: Colors.white, child: const Center(child: CircularProgressIndicator()));
      }

      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 150.0,
              backgroundColor: const Color(0xfffafafa),
              pinned: false,
              title: const Icon(Icons.menu, color: Colors.black,),
              titleSpacing: 25,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25),
                  child: InkWell(
                    onTap: (){
                      showSearch(context: context, delegate: CompanySearchDelegate(companyController: companyController));
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(0, 1),
                                blurRadius: 15,
                                spreadRadius: 0
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: const Icon(Icons.search, color: Colors.black,)
                    ),
                  ),
                ),
              ],
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.all(18),
                title: Text(
                  'Find your Dream Job today',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  final company = companyController.companyList[index];
                  return CompanyListItem(
                    company: company,
                    isApplied: companyController.isJobApplied(company.id),
                    onApply: () => companyController.applyForJob(company.id),
                  );
                }, childCount: companyController.companyList.length,
              ),
            ),
          ],
        ),
      );
    });
  }
}


class CompanySearchDelegate extends SearchDelegate {
  final CompanyController companyController;
  CompanySearchDelegate({required this.companyController});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    companyController.filterCompanies(query);
    return Obx(() {
      return ListView.builder(
        itemCount: companyController.filteredCompanyList.length,
        itemBuilder: (context, index) {
          final company = companyController.filteredCompanyList[index];
          return CompanyListItem(
            company: company,
            isApplied: companyController.isJobApplied(company.id),
            onApply: () => companyController.applyForJob(company.id),
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    companyController.filterCompanies(query);
    return Obx(() {
      return ListView.builder(
        itemCount: companyController.filteredCompanyList.length,
        itemBuilder: (context, index) {
          final company = companyController.filteredCompanyList[index];
          return ListTile(
            title: Text(company.name),
            onTap: () {
              query = company.name;
              showResults(context);
            },
          );
        },
      );
    });
  }
}