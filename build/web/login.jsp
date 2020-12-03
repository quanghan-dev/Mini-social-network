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

                    <form class="login100-form validate-form" action="MainController" method="POST" id="loginForm">
                        <span class="login100-form-title">
                            Member Login
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
                        <div class="wrap-input100" style="margin-top: 15px;">
                            <input class="input100" type="password" name="txtPassword" placeholder="Password" required>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-lock" aria-hidden="true"></i>
                            </span>
                        </div>
                        <div class="alert-warning error" style="border-radius: 10px; padding-left: 5px;">
                        ${requestScope.INVALID.pwErr}
                        </div>
                        <c:if test="${requestScope.NOTFOUND != null}">
                            <div class="alert alert-danger" style="position: relative;"><p>${requestScope.NOTFOUND}</p></div>
                                </c:if>
                        <div class="container-login100-form-btn">
                            <button class="login100-form-btn" name="action" value="Login">
                                Login
                            </button>
                        </div>

                        <div class="text-center p-t-136">
                            <a class="txt2" href="register.jsp">
                                Create your Account
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