<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
UserDetails user2 = (UserDetails) session.getAttribute("userD");

if (user2 == null) {
    //no user login
    response.sendRedirect("login.jsp");
    session.setAttribute("login-error", "Please login inorder to view home");
}
%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes - Your Digital Notebook</title>
    <%@include file="all_component/allcss.jsp" %>
    <link rel="stylesheet" href="home_style.css">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
</head>
<body class="home-page">


<%@include file="all_component/navbar.jsp"%>
<div class="page-content">

    <div class="container">
        <div class="welcome-message text-center">
            <% if(user2 != null) { %>
                <i class="fa fa-quote-left mr-2" style="opacity: 0.5"></i>
                Welcome back, <strong><%= user2.getName() %></strong>! Ready to organize your thoughts?
                <i class="fa fa-quote-right ml-2" style="opacity: 0.5"></i>
            <% } %>
        </div>
        
        <div class="hero-section text-center">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <img src="img/notes.png" alt="Digital Notes" class="img-fluid notes-image mx-auto d-block">
                    <h1 class="hero-title">Your Ideas Deserve to be Captured</h1>
                    <p class="hero-subtitle">Create, organize, and access your notes anywhere. Experience a seamless note-taking journey with our professional tools designed for your productivity.</p>
                    <a href="addNotes.jsp" class="btn cta-button">
                        <i class="fa fa-pencil mr-2"></i> Create New Note
                    </a>
                </div>
            </div>
        </div>
        
        <div class="features-section">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="feature-card text-center">
                        <div class="feature-icon">
                            <i class="fa fa-lock"></i>
                        </div>
                        <h3 class="feature-title">Secure Storage</h3>
                        <p>Your notes are encrypted and securely stored for your eyes only.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card text-center">
                        <div class="feature-icon">
                            <i class="fa fa-refresh"></i>
                        </div>
                        <h3 class="feature-title">Instant Sync</h3>
                        <p>Access your updated notes across all your devices seamlessly.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card text-center">
                        <div class="feature-icon">
                            <i class="fa fa-search"></i>
                        </div>
                        <h3 class="feature-title">Smart Search</h3>
                        <p>Find any note quickly with our powerful search functionality.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="all_component/footer.jsp" %>

<script>
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
</script>

</body>
</html>