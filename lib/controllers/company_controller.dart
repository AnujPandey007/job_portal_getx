import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/company.dart';
import '../services/api_service.dart';

class CompanyController extends GetxController {
  final companyList = <Company>[].obs;
  final appliedCompanies = <int>{}.obs;
  final filteredCompanyList = <Company>[].obs;
  final isDataLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAppliedCompanies();
    fetchCompanies();
  }

  void fetchCompanies() async {
    final companies = await ApiService().fetchCompanies();
    companyList.value = companies;
    filteredCompanyList.value = companies;
    isDataLoaded.value = true;
  }

  void applyForJob(int companyId) {
    appliedCompanies.add(companyId);
    updateFilteredList();
    saveAppliedCompanies();
    Get.snackbar('Success', 'Job Applied Successfully');
    companyList.refresh();
  }

  bool isJobApplied(int companyId) {
    return appliedCompanies.contains(companyId);
  }

  void filterCompanies(String query) {
    if (query.isEmpty) {
      filteredCompanyList.value = companyList;
    } else {
      filteredCompanyList.value = companyList
          .where((company) => company.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void updateFilteredList() {
    filteredCompanyList.value = filteredCompanyList.map((company) {
      if (appliedCompanies.contains(company.id)) {
        return Company(
          id: company.id,
          name: company.name,
          description: company.description,
          imageUrl: company.imageUrl,
        );
      }
      return company;
    }).toList();
  }

  void saveAppliedCompanies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> appliedCompanyIds = appliedCompanies.map((id) => id.toString()).toList();
    await prefs.setStringList('appliedCompanies', appliedCompanyIds);
  }

  void loadAppliedCompanies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? appliedCompanyIds = prefs.getStringList('appliedCompanies');
    if (appliedCompanyIds != null) {
      appliedCompanies.value = appliedCompanyIds.map((id) => int.parse(id)).toSet();
    }
  }

}
