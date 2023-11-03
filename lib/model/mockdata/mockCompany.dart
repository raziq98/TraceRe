import '../company.dart';

class MockCompany{
  static List<Company> companies = [
    Company(
      id: 1,
      name: "ABC Corporation",
      photo: "assets/images/picture-png.png",
      phone: "123-456-7890",
      email: "info@abc.com",
      companyBio: "A leading technology company.",
      branchId: "B123",
      establishedDate: "2020-01-15",
    ),
    Company(
      id: 2,
      name: "XYZ Industries",
      photo: "assets/images/picture-png.png",
      phone: "987-654-3210",
      email: "contact@xyz.com",
      companyBio: "Manufacturing quality products.",
      branchId: "B456",
      establishedDate: "2015-08-22",
    ),
  ];
}