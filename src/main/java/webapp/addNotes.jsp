<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
UserDetails user1 = (UserDetails) session.getAttribute("userD");
if (user1 == null) {
	session.setAttribute("login-error", "Please login to add notes");
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Notes</title>
<%@include file="all_component/allcss.jsp"%>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@400;600&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="addNotes_style.css">
<!-- Quill CSS -->
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
	rel="stylesheet">

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Times+New+Roman&family=Calibri&family=Georgia&family=Cambria&family=Verdana&display=swap')
	;

.ql-editor {
	min-height: 350px; 
	font-family: 'Open Sans', sans-serif;
	font-size: 16px;
	line-height: 1.6;
}

.ql-toolbar {
	border-top-left-radius: 8px;
	border-top-right-radius: 8px;
	background-color: #f9f9f9;
	padding: 12px;
	position: relative; /* For z-index stacking */
	z-index: 50; 
}

.ql-container {
	border-bottom-left-radius: 8px;
	border-bottom-right-radius: 8px;
	font-size: 16px;
	border: 1px solid #ddd;
}

.quill-wrapper {
	margin-bottom: 20px;
	position: relative;
}

.resize-handle {
	width: 100%;
	height: 12px;
	background-color: #f1f1f1;
	border-top: 1px solid #ddd;
	position: absolute;
	bottom: 0;
	cursor: ns-resize;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 10px;
	color: #888;
	border-bottom-left-radius: 8px;
	border-bottom-right-radius: 8px;
}

.resize-handle:hover {
	background-color: #e5e5e5;
}

.resize-handle::after {
	content: '...';
	letter-spacing: 2px;
}

.speech-controls {
	display: flex;
	align-items: center;
	justify-content: flex-end;
	margin-top: 10px;
}

.mic-button {
	background: transparent;
	border: none;
	color: #555;
	cursor: pointer;
	font-size: 18px;
	padding: 5px 10px;
	transition: all 0.3s ease;
}

.mic-button:hover {
	color: #0056b3;
}

.mic-button.active {
	color: #dc3545;
	animation: pulse 1.5s infinite;
}

@keyframes pulse { 0% 
{
	transform: scale(1);
}
50%{
transform:scale(1.1);
}
100%{
transform:scale(1);
}
}


.ql-font-times-new-roman {
	font-family: 'Times New Roman', Times, serif;
}

.ql-font-calibri {
	font-family: 'Calibri', 'Trebuchet MS', sans-serif;
}

.ql-font-georgia {
	font-family: Georgia, serif;
}

.ql-font-cambria {
	font-family: Cambria, Cochin, Georgia, Times, serif;
}

.ql-font-verdana {
	font-family: Verdana, Geneva, sans-serif;
}


.ql-editor table {
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 1em;
}

.ql-editor table td, .ql-editor table th {
	border: 1px solid #ddd;
	padding: 8px;
	min-width: 50px;
	height: 25px;
}

.ql-editor table th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: left;
	background-color: #f2f2f2;
}


.ql-editor.ql-blank::before {
	color: white !important;
	opacity: 0.7;
}


[data-tooltip] {
	position: relative;
	cursor: pointer;
}

[data-tooltip]::after {
	content: attr(data-tooltip);
	position: absolute;
	bottom: -30px;
	left: 50%;
	transform: translateX(-50%);
	background-color: #333;
	color: white;
	padding: 5px 8px;
	border-radius: 4px;
	font-size: 12px;
	white-space: nowrap;
	opacity: 0;
	visibility: hidden;
	transition: opacity 0.3s, visibility 0.3s;
	z-index: 100;
	pointer-events: none;
}

[data-tooltip]:hover::after {
	opacity: 1;
	visibility: visible;
}
</style>
</head>

<body class="d-flex flex-column min-vh-100 add-notes-page">
	<main class="flex-fill">
		<div class="container-fluid"></div>
		<%@include file="all_component/navbar.jsp"%>

		<div class="container py-4">
			<div class="row justify-content-center">
				<div class="col-lg-10">
					<div class="text-center mb-4">
						<h1 class="page-title">Create New Note</h1>
					</div>

					<div class="note-container">
						<div class="note-card">
							
							<div class="notebook-header">
								
								<div class="form-group mb-0">
									<div class="input-wrapper">
										<input type="text" class="title-input" id="title" name="title"
											placeholder="Note Title" required>
										<button type="button" class="mic-button" id="titleMicBtn"
											onclick="startTitleRecognition()" title="Click to speak">
											<i class="fa fa-microphone" aria-hidden="true"></i>
										</button>
									</div>
								</div>
							</div>

							
							<div class="notebook-body">
								<form id="noteForm" action="AddNotesServlet" method="post"
									onsubmit="return prepareFormSubmission()">
									<%
									UserDetails us = (UserDetails) session.getAttribute("userD");
									if (us != null) {
									%>
									<input type="hidden" value="<%=us.getId()%>" name="user_id">
									<input type="hidden" id="title-hidden" name="title"> <input
										type="hidden" id="content-hidden" name="content">
									<%
									}
									%>

									<!-- Quill Editor Container -->
									<div class="form-group">
										<label class="form-label" for="editor">Note Content</label>
										<div class="quill-wrapper">
											<div id="editor"></div>
											<div class="resize-handle" id="quill-resizer"
												title="Drag to resize editor"></div>
										</div>
										<div class="speech-controls">
											<button type="button" class="mic-button" id="contentMicBtn"
												onclick="startContentRecognition()" title="Click to speak">
												<i class="fa fa-microphone" aria-hidden="true"></i>
											</button>
										</div>
									</div>

									<div id="speech-warning" class="speech-indicator"></div>

									<input type="hidden" id="lat" name="lat"> <input
										type="hidden" id="lon" name="lon">

									
									<div class="btn-container">
										<button type="submit" class="btn-save">
											<i class="fa fa-save"></i>Save Note
										</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<%@include file="all_component/footer.jsp"%>

	<!-- Quill JS -->
	<script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>

	<!-- JavaScript for Quill, Speech Recognition -->
	<script>
	
	let recognition;
	let isListening = false;
	let quill;
	let startY, startHeight;

	document.addEventListener('DOMContentLoaded', function() {
	    
	    const Font = Quill.import('formats/font');
	    Font.whitelist = [
	        'sans-serif', 
	        'serif', 
	        'monospace', 
	        'times-new-roman', 
	        'calibri', 
	        'georgia', 
	        'cambria', 
	        'verdana'
	    ];
	    Quill.register(Font, true);
	    
	    
	    quill = new Quill('#editor', {
	        theme: 'snow',
	        modules: {
	            toolbar: {
	                container: [
	                    ['bold', 'italic', 'underline', 'strike'],
	                    ['blockquote', 'code-block'],
	                    [{ 'header': 1 }, { 'header': 2 }],
	                    [{ 'list': 'ordered' }, { 'list': 'bullet' }],
	                    [{ 'script': 'sub' }, { 'script': 'super' }],
	                    [{ 'indent': '-1' }, { 'indent': '+1' }],
	                    [{ 'direction': 'rtl' }],
	                    [{ 'size': ['small', false, 'large', 'huge'] }],
	                    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
	                    [{ 'font': [
	                        'sans-serif', 
	                        'serif', 
	                        'monospace', 
	                        'times-new-roman', 
	                        'calibri', 
	                        'georgia', 
	                        'cambria', 
	                        'verdana'
	                    ] }],
	                    [{ 'color': [] }, { 'background': [] }],
	                    [{ 'align': [] }],
	                    ['clean'],
	                    ['link']
	                ]
	            }
	        },
	        placeholder: 'Write your note content here...'
	    });
	    
	    
	    function addTooltipsToToolbar() {
	        
	        setTimeout(() => {
	            
	            const tooltips = {
	                '.ql-bold': 'Bold',
	                '.ql-italic': 'Italic',
	                '.ql-underline': 'Underline',
	                '.ql-strike': 'Strikethrough',
	                '.ql-blockquote': 'Blockquote',
	                '.ql-code-block': 'Code Block',
	                '.ql-header[value="1"]': 'Heading 1',
	                '.ql-header[value="2"]': 'Heading 2',
	                '.ql-list[value="ordered"]': 'Numbered List',
	                '.ql-list[value="bullet"]': 'Bullet List',
	                '.ql-script[value="sub"]': 'Subscript',
	                '.ql-script[value="super"]': 'Superscript',
	                '.ql-indent[value="-1"]': 'Decrease Indent',
	                '.ql-indent[value="+1"]': 'Increase Indent',
	                '.ql-direction': 'Text Direction',
	                '.ql-size': 'Font Size',
	                '.ql-header': 'Heading',
	                '.ql-font': 'Font Family',
	                '.ql-color': 'Text Color',
	                '.ql-background': 'Background Color',
	                '.ql-align': 'Text Alignment',
	                '.ql-clean': 'Clear Formatting',
	                '.ql-link': 'Insert Link'
	            };
	            
	            
	            Object.keys(tooltips).forEach(selector => {
	                const elements = document.querySelectorAll(selector);
	                elements.forEach(el => {
	                    el.setAttribute('data-tooltip', tooltips[selector]);
	                });
	            });
	        }, 500);
	    }
	    
	    
	    function addFontStyles() {
	        const style = document.createElement('style');
	        style.textContent = `
	            
	            .ql-snow .ql-picker.ql-font .ql-picker-label[data-value="times-new-roman"]::before,
	            .ql-snow .ql-picker.ql-font .ql-picker-item[data-value="times-new-roman"]::before {
	                content: 'Times New Roman';
	                font-family: 'Times New Roman', Times, serif;
	            }
	            
	            .ql-snow .ql-picker.ql-font .ql-picker-label[data-value="calibri"]::before,
	            .ql-snow .ql-picker.ql-font .ql-picker-item[data-value="calibri"]::before {
	                content: 'Calibri';
	                font-family: 'Calibri', 'Trebuchet MS', sans-serif;
	            }
	            
	            .ql-snow .ql-picker.ql-font .ql-picker-label[data-value="georgia"]::before,
	            .ql-snow .ql-picker.ql-font .ql-picker-item[data-value="georgia"]::before {
	                content: 'Georgia';
	                font-family: Georgia, serif;
	            }
	            
	            .ql-snow .ql-picker.ql-font .ql-picker-label[data-value="cambria"]::before,
	            .ql-snow .ql-picker.ql-font .ql-picker-item[data-value="cambria"]::before {
	                content: 'Cambria';
	                font-family: Cambria, Cochin, Georgia, Times, serif;
	            }
	            
	            .ql-snow .ql-picker.ql-font .ql-picker-label[data-value="verdana"]::before,
	            .ql-snow .ql-picker.ql-font .ql-picker-item[data-value="verdana"]::before {
	                content: 'Verdana';
	                font-family: Verdana, Geneva, sans-serif;
	            }
	            
	            
	            .ql-font-times-new-roman {
	                font-family: 'Times New Roman', Times, serif !important;
	            }
	            
	            .ql-font-calibri {
	                font-family: 'Calibri', 'Trebuchet MS', sans-serif !important;
	            }
	            
	            .ql-font-georgia {
	                font-family: Georgia, serif !important;
	            }
	            
	            .ql-font-cambria {
	                font-family: Cambria, Cochin, Georgia, Times, serif !important;
	            }
	            
	            .ql-font-verdana {
	                font-family: Verdana, Geneva, sans-serif !important;
	            }
	        `;
	        document.head.appendChild(style);
	    }
	    
	    
	    addFontStyles();
	    setTimeout(addTooltipsToToolbar, 150);
	    
	    
	    const toolbar = document.querySelector('.ql-toolbar');
	    if (toolbar) {
	        toolbar.addEventListener('mousedown', function(e) {
	            
	            e.stopPropagation();
	        });
	        
	        toolbar.addEventListener('click', function(e) {
	            
	            e.stopPropagation();
	        });
	    }
	    
	    
	    const resizeHandle = document.getElementById('quill-resizer');
	    const editorContainer = document.querySelector('.ql-editor');
	    
	    resizeHandle.addEventListener('mousedown', function(e) {
	        e.preventDefault();
	        startY = e.clientY;
	        startHeight = parseInt(window.getComputedStyle(editorContainer).height, 10);
	        
	        document.addEventListener('mousemove', resizeEditor);
	        document.addEventListener('mouseup', stopResizing);
	    });
	    
	    function resizeEditor(e) {
	        const newHeight = startHeight + (e.clientY - startY);
	        if (newHeight > 100) { 
	            editorContainer.style.height = newHeight + 'px';
	        }
	    }
	    
	    function stopResizing() {
	        document.removeEventListener('mousemove', resizeEditor);
	        document.removeEventListener('mouseup', stopResizing);
	    }
	    
	   
	    setTimeout(() => {
	        document.getElementById('title').focus();
	    }, 500);
	    
	    
	    const noteCard = document.querySelector('.note-card');
	    noteCard.style.opacity = '0';
	    noteCard.style.transform = 'translateY(20px)';
	    
	    setTimeout(() => {
	        noteCard.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
	        noteCard.style.opacity = '1';
	        noteCard.style.transform = 'translateY(0)';
	    }, 300);
	    
	    
	    document.getElementById('noteForm').addEventListener('keydown', function(e) {
	        if (e.key === 'Enter' && !e.shiftKey && e.target.tagName !== 'TEXTAREA') {
	            
	            e.preventDefault();
	            return false;
	        }
	    });
	    
	    
	    document.getElementById('noteForm').addEventListener('submit', function(e) {
	        
	        return prepareFormSubmission();
	    });
	});

	
	function prepareFormSubmission() {
	    
	    console.log("Form submission being prepared");
	    
	    
	    document.getElementById('title-hidden').value = document.getElementById('title').value;
	    
	   
	    const contentHtml = quill.root.innerHTML;
	    document.getElementById('content-hidden').value = contentHtml;
	    
	    
	    if (!document.getElementById('title').value.trim()) {
	        alert("Please enter a title for your note.");
	        document.getElementById('title').focus();
	        return false;
	    }
	    
	    return true;
	}

	
	function showFeedback(msg) {
	    const feedbackEl = document.getElementById('speech-warning');
	    feedbackEl.textContent = msg;
	    feedbackEl.style.opacity = '1';
	}

	function resetFeedback() {
	    const feedbackEl = document.getElementById('speech-warning');
	    feedbackEl.style.opacity = '0';
	    setTimeout(() => {
	        feedbackEl.textContent = '';
	    }, 300);
	}

	function startRecognition(targetType, buttonId) {
	    if (!('webkitSpeechRecognition' in window)) {
	        showFeedback("Speech recognition not supported in this browser.");
	        return;
	    }
	    
	    const button = document.getElementById(buttonId);
	    
	    if (isListening) {
	        stopRecognition();
	        return;
	    }
	    
	    recognition = new webkitSpeechRecognition();
	    recognition.lang = 'en-US';
	    recognition.interimResults = false;
	    recognition.maxAlternatives = 1;
	    
	    button.classList.add('active');
	    isListening = true;
	    
	    showFeedback("🎙️ Listening... Speak now");
	    
	    recognition.start();
	    
	    recognition.onresult = function(event) {
	        const transcript = event.results[0][0].transcript;
	        
	        if (targetType === 'title') {
	            
	            const titleInput = document.getElementById('title');
	            titleInput.value += (titleInput.value ? " " : "") + transcript;
	            
	            
	            titleInput.style.transition = 'background-color 0.3s ease';
	            titleInput.style.backgroundColor = 'rgba(6, 214, 160, 0.1)';
	            setTimeout(() => {
	                titleInput.style.backgroundColor = '';
	            }, 500);
	        } else if (targetType === 'content') {
	            
	            const range = quill.getSelection() || { index: quill.getLength(), length: 0 };
	            quill.insertText(range.index, transcript + ' ');
	            
	            
	            const editorContainer = document.querySelector('.ql-editor');
	            editorContainer.style.transition = 'background-color 0.3s ease';
	            editorContainer.style.backgroundColor = 'rgba(6, 214, 160, 0.1)';
	            setTimeout(() => {
	                editorContainer.style.backgroundColor = '';
	            }, 500);
	        }
	    };
	    
	    recognition.onerror = function(event) {
	        console.error("Speech Recognition Error:", event.error);
	        showFeedback("⚠️ Error: " + event.error + ". Please try again.");
	        stopRecognition();
	    };
	    
	    recognition.onend = function() {
	        stopRecognition();
	    };
	}

	function stopRecognition() {
	    if (recognition) {
	        recognition.stop();
	    }
	    
	    document.querySelectorAll('.mic-button').forEach(btn => {
	        btn.classList.remove('active');
	    });
	    
	    resetFeedback();
	    isListening = false;
	}

	function startTitleRecognition() {
	    startRecognition("title", "titleMicBtn");
	}

	function startContentRecognition() {
	    startRecognition("content", "contentMicBtn");
	}

	// Auto-get user location
	if (navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition(
	        position => {
	            document.getElementById("lat").value = position.coords.latitude;
	            document.getElementById("lon").value = position.coords.longitude;
	        },
	        error => console.error("Error getting location:", error)
	    );
	}
    </script>
</body>
</html>