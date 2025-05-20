<%@ page import="com.User.UserDetails"%>

<!-- Navbar - Enhanced with fixed positioning -->
<nav class="navbar navbar-expand-lg navbar-dark bg-custom navbar-custom fixed-top">
	<div class="container">
		<a class="navbar-brand" href="#">eNotes</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="home.jsp">
						<i class="fa fa-home" style="margin-right: 5px;" aria-hidden="true"></i>Home
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="addNotes.jsp">
						<i class="fa fa-plus" style="margin-right: 2px;" aria-hidden="true"></i>&nbsp;Add
						Note
				</a></li>
				<li class="nav-item"><a class="nav-link" href="showNotes.jsp">
						<i class="fa fa-address-book-o" style="margin-right: 5px;"
						aria-hidden="true"></i>Show Note
				</a></li>
			</ul>


			<!-- Dark Mode Toggle -->
			<span class="dark-mode-toggle" onclick="toggleDarkMode()"> <i
				id="darkIcon" class="fa fa-moon-o"></i>
			</span>&nbsp;&nbsp;&nbsp;



			<%
			UserDetails user = (UserDetails) session.getAttribute("userD");
			if (user != null) {
			%>
			<a href="#" class="btn btn-custom my-2 my-sm-0 mr-2 text-dark"
				data-toggle="modal" data-target="#exampleModal"> <i
				class="fa fa-user" style="margin-right: 5px;" aria-hidden="true"></i><%=user.getName()%>
			</a> <a href="logoutServlet" class="btn btn-custom my-2 my-sm-0 text-dark">
				<i class="fa fa-sign-out" aria-hidden="true"></i>Logout
			</a>
			<%
			} else {
			%>
			<a href="login.jsp" class="btn btn-custom my-2 my-sm-0 mr-2 text-dark">
				<i class="fa fa-user" style="margin-right: 5px;" aria-hidden="true"></i>Login
			</a> <a href="register.jsp" class="btn btn-custom my-2 my-sm-0 text-dark">
				<i class="fa fa-user-plus" style="margin-right: 5px;"
				aria-hidden="true"></i>Register
			</a>
			<%
			}
			%>
		</div>
	</div>
</nav>

<!-- Add spacer div to prevent content from hiding under navbar -->
<div class="navbar-spacer"></div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">

			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel" style="color: black;">User Details</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body">
				<div class="container text-center">
					<i class="fa fa-user fa-2x mb-2" aria-hidden="true" style="color: black;"></i>
					<h5 class="mb-3" style="color: black;"><%=(user != null) ? user.getName() : "Guest"%></h5>

					<table class="table table-bordered">
						<tbody>
							<tr>
								<th style="color: black;">User ID</th>
								<td style="color: black;"><%=(user != null) ? user.getId() : "N/A"%></td>
							</tr>
							<tr>
								<th style="color: black;">Full Name</th>
								<td style="color: black;"><%=(user != null) ? user.getName() : "N/A"%></td>
							</tr>
							<tr>
								<th style="color: black;">Email ID</th>
								<td style="color: black;"><%=(user != null) ? user.getEmail() : "N/A"%></td>
							</tr>
						</tbody>
					</table>

					<button type="button" class="btn btn-custom" data-dismiss="modal" >Close</button>
				</div>
			</div>

		</div>
	</div>
</div>

<style>
/* Styles for fixed navbar */
.fixed-top {
    position: fixed;
    top: 0;
    right: 0;
    left: 0;
    z-index: 1030;
}

/* Spacer to prevent content from hiding under navbar */
.navbar-spacer {
    padding-top: 70px; /* Adjust based on your navbar height */
}

/* Additional styles for smooth transition when changing modes */
.navbar {
    transition: background-color 0.3s ease;
}

/* Shadow effect for better visual separation */
.navbar-custom.fixed-top {
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

/* Dark mode adjustments for fixed navbar */
.navbar-custom.fixed-top.dark-mode {
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
}
</style>

<script>
function applyDarkMode(isDark) {
    const body = document.body;
    const footer = document.querySelector("footer");
    const navbar = document.querySelector(".navbar");
    const icon = document.getElementById("darkIcon");
    const backImg = document.querySelector(".back-img");
    const heroSection = document.querySelector(".hero-section");

    if (isDark) {
        body.classList.add("dark-mode");
        navbar?.classList.add("dark-mode");
        footer?.classList.add("dark-mode");

        document.querySelectorAll(".btn-custom").forEach(btn => 
            btn.classList.add("dark-mode")
        );

        if (backImg) {
            backImg.classList.add("dark-mode");
            backImg.classList.remove("light-mode");
        }
        
        if (heroSection) {
            heroSection.classList.remove("light-mode");
            heroSection.classList.add("dark-mode");
        }

        if (icon) {
            icon.classList.remove("fa-moon-o");
            icon.classList.add("fa-sun-o");
        }
    } else {
        body.classList.remove("dark-mode");
        navbar?.classList.remove("dark-mode");
        footer?.classList.remove("dark-mode");

        document.querySelectorAll(".btn-custom").forEach(btn => 
            btn.classList.remove("dark-mode")
        );

        if (backImg) {
            backImg.classList.remove("dark-mode");
            backImg.classList.add("light-mode");
        }
        
        if (heroSection) {
            heroSection.classList.remove("dark-mode");
            heroSection.classList.add("light-mode");
        }

        if (icon) {
            icon.classList.remove("fa-sun-o");
            icon.classList.add("fa-moon-o");
        }
    }
}

function toggleDarkMode() {
    const isDark = document.body.classList.contains("dark-mode");
    const newMode = !isDark;
    localStorage.setItem("darkMode", newMode);
    applyDarkMode(newMode);
}

// On page load
window.addEventListener("DOMContentLoaded", () => {
    const isDark = localStorage.getItem("darkMode") === "true";

    // Don't apply dark background for index.jsp
    const isIndexPage = window.location.pathname.includes("index.jsp");
    if (isDark) {
        if (!isIndexPage) {
            document.body.classList.add("dark-mode");
        }
        applyDarkMode(true);
    }
});
</script>