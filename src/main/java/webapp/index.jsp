<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>eNotes - Your Digital Notebook</title>
<%@include file="all_component/allcss.jsp"%>
<link rel="stylesheet" href="index_style.css">
</head>
<body class="no-darkmode">

	<%@include file="all_component/navbar.jsp"%>

	<div class="container-fluid hero-section light-mode" id="bg-image">
		<div class="hero-content">
			<h1 class="hero-title">eNotes</h1>
			<p class="hero-subtitle">Capture ideas, organize thoughts, access
				anywhere</p>

			<div class="btn-group">
				<a href="login.jsp"
					class="btn btn-custom1 my-2 my-sm-0 mr-3 text-white"> <i
					class="fa fa-user btn-icon" aria-hidden="true"></i>Login
				</a> <a href="register.jsp"
					class="btn btn-custom1 my-2 my-sm-0 text-white"> <i
					class="fa fa-user-plus btn-icon" aria-hidden="true"></i>Register
				</a>
			</div>
		</div>

		<div class="features-section">
			<div class="feature-card">
				<div class="feature-icon">
					<i class="fa fa-shield" aria-hidden="true"></i>
				</div>
				<h3 class="feature-title">Secure Storage</h3>
				<p class="feature-desc">Your notes are encrypted and securely
					stored, protecting your private information and sensitive data.</p>
			</div>

			<div class="feature-card">
				<div class="feature-icon">
					<i class="fa fa-bolt" aria-hidden="true"></i>
				</div>
				<h3 class="feature-title">Quick Access</h3>
				<p class="feature-desc">Find what you need instantly with
					powerful search and tagging features. No more lost information.</p>
			</div>

			<div class="feature-card">
				<div class="feature-icon">
					<i class="fa fa-laptop" aria-hidden="true"></i>
				</div>
				<h3 class="feature-title">Cross-Platform</h3>
				<p class="feature-desc">Access your notes from any device.
					Changes sync automatically for seamless productivity.</p>
			</div>
		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>

	<script>

function applyDarkMode(isDark) {
    const body = document.body;
    const footer = document.querySelector("footer");
    const navbar = document.querySelector(".navbar");
    const icon = document.getElementById("darkIcon");
    const heroSection = document.querySelector(".hero-section");
    const featureCards = document.querySelectorAll(".feature-card");

    if (isDark) {
        body.classList.add("dark-mode");
        navbar?.classList.add("dark-mode");
        footer?.classList.add("dark-mode");
        
        if (heroSection) {
            heroSection.classList.remove("light-mode");
            heroSection.classList.add("dark-mode");
        }

        document.querySelectorAll(".btn-custom").forEach(btn => 
            btn.classList.add("dark-mode")
        );

        if (icon) {
            icon.classList.remove("fa-moon-o");
            icon.classList.add("fa-sun-o");
        }
    } else {
        body.classList.remove("dark-mode");
        navbar?.classList.remove("dark-mode");
        footer?.classList.remove("dark-mode");
        
        if (heroSection) {
            heroSection.classList.remove("dark-mode");
            heroSection.classList.add("light-mode");
        }

        document.querySelectorAll(".btn-custom").forEach(btn => 
            btn.classList.remove("dark-mode")
        );

        if (icon) {
            icon.classList.remove("fa-sun-o");
            icon.classList.add("fa-moon-o");
        }
    }
}
</script>

</body>
</html>
