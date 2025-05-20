<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.DAO.postDAO"%>
<%@ page import="com.User.Post"%>
<%@ page import="com.User.UserDetails"%>
<%@ page import="java.util.List"%>

<%
UserDetails user3 = (UserDetails) session.getAttribute("userD");
if (user3 == null) {
	session.setAttribute("login-error", "Please login to view your notes.");
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show Notes</title>
<%@ include file="all_component/allcss.jsp"%>

<!-- Leaflet CSS & JS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

<link rel="stylesheet" href="showNotes_style.css">
</head>
<body class="show-notes-page">

<%@ include file="all_component/navbar.jsp"%>

<!-- Page Header -->
<div class="page-header text-center">
    <div class="container">
        <h1 class="page-title">My Notes Collection</h1>
    </div>
</div>

<!-- Alert Messages -->
<div class="container mt-3">
    <%
    String updateMsg = (String) session.getAttribute("updateMsg");
    if (updateMsg != null) {
    %>
    <div class="alert alert-success alert-custom alert-dismissible fade show" role="alert">
        <i class="fas fa-check-circle me-2"></i> <%=updateMsg%>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <%
    session.removeAttribute("updateMsg");
    }
    String wrongMsg = (String) session.getAttribute("wrongMsg");
    if (wrongMsg != null) {
    %>
    <div class="alert alert-danger alert-custom alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-circle me-2"></i> <%=wrongMsg%>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <%
    session.removeAttribute("wrongMsg");
    }
    String deleteMsg = (String) session.getAttribute("DeleteMsg");
    if (deleteMsg != null) {
    %>
    <div class="alert alert-warning alert-custom alert-dismissible fade show" role="alert">
        <i class="fas fa-trash-alt me-2"></i> <strong>Deleted!</strong> <%=deleteMsg%>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <%
    session.removeAttribute("DeleteMsg");
    }
    %>
</div>

<!-- Notes Section -->
<div class="container notes-container">
    <%
    postDAO ob = new postDAO(DBConnect.getConn());
    List<Post> poList = ob.getData(user3.getId());

    if (poList.isEmpty()) {
    %>
    <div class="empty-notes">
        <i class="fas fa-sticky-note empty-notes-icon"></i>
        <h3>No Notes Found</h3>
        <p class="text-muted">You haven't created any notes yet.</p>
        <a href="addNotes.jsp" class="btn btn-action btn-edit mt-3">
            <i class="fas fa-plus"></i> Create Your First Note
        </a>
    </div>
    <%
    } else {
    %>
    <div class="row">
        <% 
        int delay = 0;
        for (Post po : poList) { 
            delay += 100; // Incremental delay for animation
        %>
        <div class="col-lg-6 col-md-12 mb-4">
            <div class="note-card animated-card" style="animation-delay: <%=delay%>ms">
                <div class="note-header">
                    <img src="img/notes.png" class="note-icon" alt="Note">
                    <h5 class="note-title"><%=po.getTitle()%></h5>
                </div>
                <div class="note-body">
                    <div class="note-content"><%=po.getContent()%></div>
                    
                    <div class="note-meta">
                        <div class="note-meta-item">
                            <i class="fas fa-user note-meta-icon"></i>
                            <span><%=user3.getName()%></span>
                        </div>
                        <div class="note-meta-item">
                            <i class="fas fa-calendar-alt note-meta-icon"></i>
                            <span><%=po.getPdate()%></span>
                        </div>
                    </div>

                    <!-- Delete Confirmation -->
                    <div class="delete-confirm-box" id="delete-confirm-<%=po.getId()%>">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <strong>Confirm deletion:</strong> This action cannot be undone.
                            </div>
                            <div class="ml-3">
                                <a href="deleteServlet?node_id=<%=po.getId()%>" class="btn btn-sm btn-danger">Yes, Delete</a>
                                <button type="button" class="btn btn-sm btn-secondary" onclick="hideDeleteConfirm(<%=po.getId()%>)">Cancel</button>
                            </div>
                        </div>
                    </div>

                    <!-- Map Section -->
                    <% if (po.getLat() != 0.0 && po.getLon() != 0.0) { %>
                    <div class="note-meta-item mt-2">
                        <i class="fas fa-map-marker-alt note-meta-icon"></i>
                        <span id="location-<%=po.getId()%>">Loading location...</span>
                    </div>
                    
                    <div class="map-container">
                        <div id="map-<%=po.getId()%>" style="height: 250px;"></div>
                    </div>
                    
                    <script>
                    
                    if (typeof window.mapInstances === 'undefined') {
                        window.mapInstances = {};
                    }
                    
                    fetch(`https://api.opencagedata.com/geocode/v1/json?q=<%=po.getLat()%>+<%=po.getLon()%>&key=8fc9b07b9695492c84b12c9caef5c0d2`)
                      .then(res => res.json())
                      .then(data => {
                        const loc = data.results[0]?.formatted || "Location unavailable";
                        document.getElementById("location-<%=po.getId()%>").textContent = loc;
                      })
                      .catch(err => {
                        console.error(err);
                        document.getElementById("location-<%=po.getId()%>").textContent = "Error fetching location";
                      });
                    
                    
                    setTimeout(() => {
                        const map = L.map('map-<%=po.getId()%>').setView([<%=po.getLat()%>, <%=po.getLon()%>], 13);
                        
                        
                        window.mapInstances['<%=po.getId()%>'] = map;
                        
                        const isDarkMode = document.body.classList.contains('dark-mode');
                        const tileLayer = isDarkMode ? 
                            'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png' : 
                            'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png';
                            
                        L.tileLayer(tileLayer, {
                            attribution: '&copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
                            maxZoom: 19
                        }).addTo(map);
                        
                        L.marker([<%=po.getLat()%>, <%=po.getLon()%>])
                            .addTo(map)
                            .bindPopup('<%=po.getTitle()%>')
                            .openPopup();
                    }, 300);
                    </script>
                    <% } %>

                    <div class="note-actions">
                        <a href="edit.jsp?note_id=<%=po.getId()%>" class="btn btn-action btn-edit">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <button class="btn btn-action btn-delete" onclick="showDeleteConfirm(<%=po.getId()%>)">
                            <i class="fas fa-trash-alt"></i> Delete
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } %>
</div>

<script>

if (typeof window.mapInstances === 'undefined') {
    window.mapInstances = {};
}


function showDeleteConfirm(id) {
    document.getElementById('delete-confirm-' + id).style.display = 'block';
}

function hideDeleteConfirm(id) {
    document.getElementById('delete-confirm-' + id).style.display = 'none';
}


function initializeMaps() {
    
    document.querySelectorAll('[id^="map-"]').forEach(mapElement => {
        const noteId = mapElement.id.replace('map-', '');
        const latElement = document.getElementById('lat-' + noteId);
        const lonElement = document.getElementById('lon-' + noteId);
        
        if (latElement && lonElement) {
            const lat = parseFloat(latElement.value);
            const lon = parseFloat(lonElement.value);
            
            if (!isNaN(lat) && !isNaN(lon)) {
                
                setTimeout(() => {
                    
                    const map = L.map('map-' + noteId).setView([lat, lon], 13);
                    
                    
                    window.mapInstances[noteId] = map;
                    
                   
                    const isDarkMode = document.body.classList.contains('dark-mode');
                    
                    
                    const tileLayer = isDarkMode ? 
                        'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png' : 
                        'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png';
                    
                    
                    L.tileLayer(tileLayer, {
                        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
                        maxZoom: 19
                    }).addTo(map);
                    
                    
                    const title = document.querySelector('.note-title') ? 
                        document.querySelector('.note-title').innerText : 'Note Location';
                    
                    L.marker([lat, lon])
                        .addTo(map)
                        .bindPopup('<strong>' + title + '</strong>')
                        .openPopup();
                    
                    
                    fetchLocationName(lat, lon, noteId);
                }, 300);
            }
        }
    });
}


function fetchLocationName(lat, lon, noteId) {
    const locationElement = document.getElementById('location-' + noteId);
    if (locationElement) {
        locationElement.textContent = 'Loading location...';
        
        fetch(`https://api.opencagedata.com/geocode/v1/json?q=${lat}+${lon}&key=8fc9b07b9695492c84b12c9caef5c0d2`)
          .then(response => {
              if (!response.ok) {
                  throw new Error('Network response was not ok');
              }
              return response.json();
          })
          .then(data => {
              const loc = data.results && data.results[0] ? data.results[0].formatted : "Location unavailable";
              locationElement.textContent = loc;
          })
          .catch(error => {
              console.error('Error fetching location:', error);
              locationElement.textContent = "Error fetching location";
          });
    }
}


function updateMapStyles() {
    const isDarkMode = document.body.classList.contains('dark-mode');
    
    
    Object.keys(window.mapInstances).forEach(noteId => {
        const map = window.mapInstances[noteId];
        
        if (map) {
            
            map.eachLayer(layer => {
                if (layer instanceof L.TileLayer) {
                    map.removeLayer(layer);
                }
            });
            
            
            if (isDarkMode) {
                L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
                    attribution: '&copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
                    maxZoom: 19
                }).addTo(map);
            } else {
                L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png', {
                    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
                    maxZoom: 19
                }).addTo(map);
            }
            
            
            map.invalidateSize();
        }
    });
}


function toggleDarkMode() {
    document.body.classList.toggle('dark-mode');
    updateMapStyles();
    
    
    const isDarkMode = document.body.classList.contains('dark-mode');
    localStorage.setItem('darkMode', isDarkMode ? 'true' : 'false');
}


function applyThemePreference() {
    const savedDarkMode = localStorage.getItem('darkMode') === 'true';
    if (savedDarkMode) {
        document.body.classList.add('dark-mode');
    } else {
        document.body.classList.remove('dark-mode');
    }
}

const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
        if (mutation.attributeName === 'class') {
            updateMapStyles();
        }
    });
});

observer.observe(document.body, { attributes: true });


function initializeCardAnimations() {
    const cards = document.querySelectorAll('.animated-card');
    cards.forEach((card, index) => {
        card.style.opacity = '0';
        card.style.animationDelay = (index * 100) + 'ms';
    });
    
    setTimeout(() => {
        cards.forEach(card => {
            card.style.opacity = '1';
        });
    }, 100);
}


document.addEventListener('DOMContentLoaded', function() {
    
    applyThemePreference();
    
    
    initializeMaps();
    
    
    initializeCardAnimations();
    
    
    const darkModeToggle = document.getElementById('dark-mode-toggle');
    if (darkModeToggle) {
        darkModeToggle.addEventListener('click', toggleDarkMode);
    }
});
</script>

<%@ include file="all_component/footer.jsp"%>
</body>
</html>