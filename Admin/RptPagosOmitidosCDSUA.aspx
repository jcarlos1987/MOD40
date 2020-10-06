<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="RptPagosOmitidosCDSUA.aspx.cs" Inherits="Admin_RptPagosOmitidosCDSUA" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
  <div class="progressbar-heading grids-heading">
            <h2>Reporte de Pagos Omitidos (CD-SUA)</h2>
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
											<label class="col-md-2 control-label">Seleccione una Opción : </label>
											<div class="col-md-12">
												<div class="input-group">							
													<span class="input-group-addon">
														<i class="fa fa-building-o"></i>
													</span>
                                                    <asp:DropDownList ID="DropDownList2" runat="server" class="form-control1">
                                                        <asp:ListItem Value="" disabled selected >-- Seleciona el Tipo --</asp:ListItem>
                                                    </asp:DropDownList>													
												</div>
											</div>
                                            <label class="col-md-2 control-label">Seleccione una Opción : </label>
                                            <div class="col-md-12">
												<div class="input-group">							
													<span class="input-group-addon">
														<i class="fa fa-moon-o"></i>
													</span>
                                                        <asp:DropDownList ID="DropDownList1" runat="server" class="form-control1" >
                                                            <asp:ListItem Value="" disabled selected >-- Seleciona el numero de meses omitidos  --</asp:ListItem>                                                            
                                                        </asp:DropDownList>											
												</div>
											</div>
										</div>
                                     <div class="row panel-title">
                                    <div class="form-group">
                                        <div class="col-md-10">
                                            <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="Generar Reporte" OnClick="Button1_Click" />
                                            </div>
											</div>
                                         </div>
                                    </form>
							</div>
                                <div id="alert_uno" class="alert alert-success" role="alert" runat="server" visible="false">
								<strong>Mensaje!</strong> <asp:Literal ID="Literal2" runat="server"></asp:Literal>
							   </div>
                                </div>
						</div>
					</div>
					<div class="clearfix"> </div>
				</div>
            </div>
        </div>
</asp:Content>

