<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="cambiar.aspx.cs" Inherits="Admin_cambiar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../alertify/lib/alertify.js"></script>
    <link rel="stylesheet" href="../alertify/themes/alertify.core.css" />
    <link rel="stylesheet" href="../alertify/themes/alertify.default.css" id="toggleCSS" />
  <%--  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>--%>
    <script type="text/javascript">
        alertify.message('Mensaje Normal', 10, null);

        function error() {
            alertify.error("Usuario o constraseña incorrecto/a.");
            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" Runat="Server">
        <ul class="nav" id="side-menu">
        <li>
            <a href="Default.aspx"><i class="fa fa-home nav_icon"></i>Inicio</a>
        </li>
        <li>
            <a href="#"><i class="fa fa-database nav_icon"></i>Base CD-SUA<span class="fa arrow"></span></a>
            <ul class="nav nav-second-level collapse">
                
                        <li><a href="RtpPagosCDSUA.aspx">Reporte de Pagos Realizados</a></li>
                        <li><a href="RptPagosxAnioCDSUA.aspx">Reporte de Pagos por Año</a></li>
                        <li><a href="RptPagosxPeriodoCDSUA.aspx">Reporte de Pagos por Periodo</a></li>
                        <li><a href="RptPagosOmitidosCDSUA.aspx">Reporte de Pagos Omitidos</a></li>
                        <li><a href="SolicCertPago.aspx">Solicitud Certificación de Pagos</a></li>
                        <li><a href="CertPagos.aspx">Certificación de Pagos</a></li>
            </ul>
            <!-- /nav-second-level -->
        </li>
        <li>
            <a href="#"><i class="fa fa-database nav_icon"></i>Base Div. de Reg. y Admon. de App.<span class="fa arrow"></span></a>
            <ul class="nav nav-second-level collapse">
               
                   
                        <li><a href="Rpt_Pagos_RealizadosNivCent.aspx">Reporte de Pagos Realizados</a></li>
                        <li><a href="RptPagosporAnioNC.aspx">Reporte de Pagos por Año</a></li>
                        <li><a href="RptpagoxperiodNC.aspx">Reporte de Pagos por Periodo</a></li>
                        <li><a href="RptPagosOmitidosNC.aspx">Reporte de Pagos Omitidos</a></li>
            </ul>
            <!-- /nav-second-level -->
        </li>
        <li>
            <a href="#"><i class="fa fa-cloud-upload nav_icon"></i>Administración de Información<span class="fa arrow"></span></a>
            <ul class="nav nav-second-level collapse">
                <li>
                    <a href="Carga_CD-SUA.aspx">Cargar CD-SUA</a>
                </li>

                <li>

                <a href="Carga_Arch_Niv_Central.aspx">Carga del Archivo de la División de Registro y Admin. de Aplicaiones</a>
                </li>

            </ul>
        </li>
            <li>
            <a href="#"><i class="fa fa-cog nav_icon"></i>Configuración<span class="fa arrow"></span></a>
            <ul class="nav nav-second-level collapse">
                <li>
                    <a href="cambiar.aspx">Cambiar Contraseña</a>
                </li>
            </ul>
        </li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row four-grids">
        <div class="grids">
            <div class="progressbar-heading grids-heading">
                <h2>Cambio de contraseña</h2>
            </div>
            <div class="panel panel-widget">
                <div class="block-page">
                    <div class="row">
                        <div class="col-md-12 program-grid">
                            <div class="panel panel-widget">
                                <div class="panel-title">
                                    Ingresa los datos 
                                    <ul class="panel-tools">
                                        <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                        <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                                    </ul>
                                </div>
                                <div class="panel-body">
                                    <div class="form-body form-body-info">
                                        <form class="form-horizontal">
                                            <div class="form-group">
                                                <label class="col-md-2 control-label">Contraseña Anterior :</label>
                                                <div class="col-md-12">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-user"></i>
                                                        </span>
                                                        <asp:TextBox ID="PassAnterior" CssClass="form-control1" runat="server" placeholder="Ingresa Contraseña Anterior" AutoPostBack="true" OnTextChanged="TextBox1_TextChanged" TextMode="Password"  ></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                             <div class="form-group">
                                                  <label class="col-md-2 control-label">Contraseña Nueva :</label>
                                                <div class="col-md-12">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-user"></i>
                                                        </span>
                                                        <asp:TextBox ID="PassNueva" CssClass="form-control1" runat="server" placeholder="Ingresa contraseña nueva" TextMode="Password"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                             <div class="form-group">
                                                  <label class="col-md-2 control-label">Confirmar Contraseña :</label>
                                                <div class="col-md-12">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-user"></i>
                                                        </span>
                                                        <asp:TextBox ID="ConfirPass" CssClass="form-control1" runat="server" placeholder="Confirmar nueva contraseña" TextMode="Password"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row panel-title">
                                                <div class="form-group">
                                                    <div class="col-md-10">
                                                        <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" OnClick="Button1_Click"  Text="Cambiar Contraseña" />
                                                    </div>
                                                </div>                                              

                                            </div>
                                        </form>





							</div>



                                
                                

                                     

                                </div>
                             

						</div>
                        
					</div>
					<div class="clearfix"> </div>
				</div>
            </div>
        </div>
    </div>
        <div class="clearfix"> </div>
    </div>
</asp:Content>

