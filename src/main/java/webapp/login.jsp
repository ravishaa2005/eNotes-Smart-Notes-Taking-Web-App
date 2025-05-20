<!DOCTYPE html>
<html>
<head>
    <%@include file="all_component/allcss.jsp"%>
    <link rel="stylesheet" href="login_style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | eNotes</title>
</head>
<body class="login-page">
    <%@include file="all_component/navbar.jsp"%>
    
    <div class="container-fluid div-color">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card mt-4">
                    <div class="card-header text-center text-white bg-custom">
                        <i class="fa fa-user-circle fa-3x" aria-hidden="true"></i>
                        <h4>Welcome Back</h4>
                    </div>

                    <% 
                    String invalidMsg = (String) session.getAttribute("login-failed");
                    if (invalidMsg != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        <i class="fa fa-exclamation-circle" aria-hidden="true"></i> <%=invalidMsg%>
                    </div>
                    <%
                    session.removeAttribute("login-failed");
                    }
                    %>

                    <%
                    String withoutLogin = (String) session.getAttribute("login-error");
                    if (withoutLogin != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        <i class="fa fa-exclamation-circle" aria-hidden="true"></i> <%=withoutLogin%>
                    </div>
                    <%
                    session.removeAttribute("login-error");
                    }
                    %>
                    
                    <%
                    String logoutMsg = (String) session.getAttribute("logoutMsg");
                    if (logoutMsg != null) {
                    %>
                    <div class="alert alert-success" role="alert">
                        <i class="fa fa-check-circle" aria-hidden="true"></i> <%=logoutMsg%>
                    </div>
                    <%
                    session.removeAttribute("logoutMsg");
                    }
                    %>

                    <div class="card-body">
                        <form action="loginServlet" method="post">
                            <div class="form-group">
                                <label><i class="fa fa-envelope" aria-hidden="true"></i> Email Address</label>
                                <input type="email" class="form-control" id="exampleInputEmail1"
                                    placeholder="Enter your email" name="user_email" required>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1"><i class="fa fa-lock" aria-hidden="true"></i> Password</label>
                                <input type="password" class="form-control" id="exampleInputPassword1"
                                    placeholder="Enter your password" name="user_password" required>
                            </div>
                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" id="rememberMe" name="remember">
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>
                            <button type="submit" class="btn btn-primary badge-pill btn-block container-fluid1">
                                <i class="fa fa-sign-in" aria-hidden="true"></i> Login
                            </button>
                            
                            <div class="signup-container">
                                <p class="signup-text">Don't have an account?</p>
                                <a href="register.jsp" class="signup-link">
                                    <i class="fa fa-user-plus" aria-hidden="true"></i> Sign up
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="all_component/footer.jsp"%>
    
    <!-- Dark Mode Toggle Script -->
    <script>
        
        if (localStorage.getItem('darkMode') === 'true' || 
            (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches && 
             localStorage.getItem('darkMode') !== 'false')) {
            document.body.classList.add('dark-mode');
        }
    </script>
</body>
</html>