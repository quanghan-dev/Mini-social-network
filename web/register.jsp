<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Mini Social Network</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <!--===============================================================================================-->
    </head>
    <body>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <div class="login100-pic js-tilt" data-tilt>
                        <img src="images/login.png" alt="IMG">
                    </div>

                    <form class="login100-form" action="MainController" method="POST" id="loginForm">
                        <span class="login100-form-title">
                            Create Your Account
                        </span>


                        <div class="wrap-input100">
                            <input class="input100" type="text" name="txtEmail" placeholder="Email" required value="${requestScope.INVALID.id}">
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-envelope" aria-hidden="true"></i>
                            </span>
                        </div>
                        <div class="alert-warning error" style="border-radius: 10px; padding-left: 5px;">
                        ${requestScope.INVALID.idErr}
                        </div>
                        <div class="wrap-input100">
                            <input class="input100" type="text" name="txtName" placeholder="Name" required value="${requestScope.INVALID.name}">
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-user" aria-hidden="true"></i>
                            </span>
                        </div>
                        <div class="alert-warning error" style="border-radius: 10px; padding-left: 5px;">
                        ${requestScope.INVALID.nameErr}
                        </div>
                        <div class="wrap-input100">
                            <input class="input100" type="password" name="txtPassword" placeholder="Password" required>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-lock" aria-hidden="true"></i>
                            </span>
                        </div>
                        <div class="alert-warning error" style="border-radius: 10px; padding-left: 5px;">
                        ${requestScope.INVALID.pwErr}
                        </div>
                        <div class="wrap-input100">
                            <input class="input100" type="password" name="txtConfirm" placeholder="Confirm Password" required>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-lock" aria-hidden="true"></i>
                            </span>
                        </div>
                        <div class="alert-warning error" style="border-radius: 10px; padding-left: 5px;">
                        ${requestScope.INVALID.confirmErr}
                        </div>
                        <c:if test="${requestScope.EXIST != null}">
                            <div class="alert alert-danger" style="position: relative;"><span>${requestScope.EXIST}</span></div>
                        </c:if>
                        <c:if test="${requestScope.SUCCESS != null}">
                            <div class="alert alert-success" style="position: relative;"><span>${requestScope.SUCCESS}</span></div>
                        </c:if>
                        <div class="container-login100-form-btn">
                            <button class="login100-form-btn" name="action" value="Verify">
                                Sign Up
                            </button>
                        </div>

                        <div class="text-center p-t-136">
                            <a class="txt2" href="login.jsp">
                                Login Your Account
                                <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                            </a>
                        </div>  
                    </form>
                </div>
            </div>
        </div>




        <!--===============================================================================================-->	
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/tilt/tilt.jquery.min.js"></script>
        <script >
            $('.js-tilt').tilt({
                scale: 1.1
            })
        </script>
        <!--===============================================================================================-->


    </body>

</html>