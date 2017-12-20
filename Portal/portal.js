b = angular.element('[name=loginButton]').get(0)
f = angular.element(b).scope();
l = f.model.LoginCredentials;
l.UserType = "2";
l.UserName = "ojoshi7782";
l.Password = "0957782";
l.RememberMe = true;
f.model.PasswordHints.forEach(function(a) {
    a.Response = "None"
});
f.$apply();
b.click()
