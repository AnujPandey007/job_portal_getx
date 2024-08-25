import 'package:get/get.dart';
import '../models/company.dart';
import '../services/api_service.dart';

class CompanyController extends GetxController {
  var companyList = <Company>[].obs;
  var appliedCompanies = <int>{}.obs;
  var filteredCompanyList = <Company>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }

  void fetchCompanies() async {
    var companies = await ApiService().fetchCompanies();
    companyList.value = companies;
    filteredCompanyList.value = companies;
  }

  void applyForJob(int companyId) {
    appliedCompanies.add(companyId);
    updateFilteredList();

    Get.snackbar('Success', 'Job Applied Successfully');
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
}
