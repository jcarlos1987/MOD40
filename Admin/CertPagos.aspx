<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterAfil.master" AutoEventWireup="true" CodeFile="CertPagos.aspx.cs" Inherits="Admin_CertPagos" %>

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
                <li><a href="RptPagosOmitidosNC.aspx">Reporte de Pagos Omitidos</a></li>
                <li><a href="#">Solicitud Certificación de Pagos</a></li>
                <li><a href="#">Certificación de Pagos</a></li>
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
            <h2>Certificación de Pagos</h2>
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
											<%--<label class="col-md-2 control-label">Digite Número de Seguridad Social o Nombre :</label>--%>
											<div class="col-md-12">
												<div class="input-group">							
													<span class="input-group-addon">
														<i class="fa fa-envelope-o"></i>
													</span>
													<input type="text" class="form-control1" placeholder="N.S.S. o Nombre del Trabajador">
												</div>
											</div>
										</div>
                                    <label class="col-md-12 control-label"></label>
                                    <div class="form-group">
                                        <div class="col-md-10">
                                            <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="Consultar" />
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
</asp:Content>

