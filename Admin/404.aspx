<%@ Page Language="C#" AutoEventWireup="true" CodeFile="404.aspx.cs" Inherits="Admin_404" %>

<!DOCTYPE HTML>
<html>
<head>
<title>MODALIDAD 40 ||  <% if (Request.Cookies["Nombre"] != null) { Response.Write(Request.Cookies["Nombre"].Value); } else { Response.Redirect("~/Default.aspx"); }%></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Modalidad 40" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- Bootstrap Core CSS -->
<link href="../esilos_admin/css/bootstrap.css" rel='stylesheet' type='text/css' />
<!-- Custom CSS -->
<link href="../esilos_admin/css/style.css" rel='stylesheet' type='text/css' />
<!-- font CSS -->
<link rel="icon" href="favicon.ico" type="image/x-icon" >
<!-- font-awesome icons -->
<link href="../esilos_admin/css/font-awesome.css" rel="stylesheet"> 
<!-- //font-awesome icons -->
<!--webfonts-->
<link href='//fonts.googleapis.com/css?family=Roboto+Condensed:400,300,300italic,400italic,700,700italic' rel='stylesheet' type='text/css'>
<!--//webfonts--> 
<!-- js -->
<script src="../esilos_admin/js/jquery-1.11.1.min.js"></script>
<!-- //js -->
</head> 
<body class="cbp-spmenu-push">
		<div class="error-page-body">
			<div class="error-page">
				<img src="../esilos_admin/images/bloqueo.png" alt="" />
			</div>
			<div class="go-back">
				<a href="javascript:history.back(1)"> Regresar </a>
			</div>
		</div>
		<div class="copyright login-copyright error-copyright">
           <p>©2017 Katia Marcela Mendoza Ghigliazza || Titular de la Jefatura de Servicios de Afiliación y Cobranza </p>    
		</div>
</body>
</html>
