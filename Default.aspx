<%@ Page Language="C#" AutoEventWireup="true" Debug="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Modalidad 40</title>

<!-- Meta tag Keywords -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Space Login Form Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- Meta tag Keywords -->

<!-- css files -->
<link href="estilos_logueo/css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- css files -->

<!-- Online-fonts -->
<link href="//fonts.googleapis.com/css?family=Montserrat:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&amp;subset=latin-ext,vietnamese" rel="stylesheet">
<!-- //Online-fonts -->
</head>
<body>
    <!-- main -->
	<div class="main">
        <form action="#" method="post" runat="server">
		<div class="main-w3l">
			<h1 class="logo-w3">Modalidad 40</h1>
			<div class="w3layouts-main">
				<h2><span>Logueo</span></h2>
				<div class="social">
					
				</div>
				
					
						 <asp:TextBox ID="inputusuario" runat="server" placeholder="Usario" name="Usuario" type="text"></asp:TextBox>
                         <asp:TextBox ID="inputPassword" runat="server" placeholder="Password" name="Password" type="password"></asp:TextBox>						
                        <asp:Button ID="Button1" runat="server" Text="Acceder" class="btn btn-login" onclick="Button1_Click" type="submit" name="login" />
					
					<h6><a href="#">Olvidaste tu Password?</a></h6>
			</div>
			<!-- //main -->
			
			<!--footer-->
			<div class="footer-w3l">
				<p>&copy; Katia Marcela Mendoza Ghigliazza | Titular de la Jefatura de Servicios de Afiliación y Cobranza</p>
                <p> Dudas y Aclaraciones comunicarse con el equipo de Desarrollo Inform&aacute;tico de la Jefatura de Servicios De Afiliaci&oacute;n y Cobranza al siguiente correo <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">isaac.barrientos@imss.gob.mx</asp:LinkButton> , a el n&uacute;mero 722 2 14 50 77 / 722 2 14 55 50 ext 1253</p>
			</div>
			<!--//footer-->
		</div>
    </form>
	</div>
</body>
</html>
