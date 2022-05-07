import 'package:first_app/models/recruteur.dart';
import 'package:first_app/screens/auth/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/Student.dart';

class RememberController extends GetxController {
  RememberRecruter(Recruteur recruteur) {
    var storage = GetStorage();
    token(1);
    storage.write("user", {
      'email': recruteur.emailr,
      'name': recruteur.companyName,
      'url': recruteur.logoUrl,
      'id': recruteur.uid,
      'location': recruteur.location
    });
  }

  RememberStudent(Student student) {
    var storage = GetStorage();
    token(2);
    storage.write("user", {
      'email': student.email,
      'name': "${student.firstName} ${student.lastName} ",
      'url': student.url,
      'id': student.uid
    });
  }

  token(int index) {
    var storage = GetStorage();
    storage.write("auth", 1); // fama chkon 3mal login :)
    storage.write("type_auth", index);
  }

  Logout() async {
    var storage = GetStorage();
    storage.write("auth", 0);
    storage.remove("user");
    Get.to(LoginScreen());
  }

  check() {
    var storage = GetStorage();
    storage.write("seen", 1);
  }
}
