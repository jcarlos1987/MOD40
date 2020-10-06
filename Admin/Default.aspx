<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Menu" Runat="Server">
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
            <ul class="nav nav-second-level ">
                <li>
                    <li><a href="Carga_CD-SUA.aspx">Cargar CD-SUA</a></li>
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form data-toggle="validator">
    <!-- four-grids -->
				<div class="row four-grids">
					<div class="col-md-6 ticket-grid">
						<div class="tickets">
							<div class="grid-left">
								<div class="book-icon">
									<i class="fa fa-database fa-4x"></i>
								</div>
							</div>
							<div class="grid-right">
								<a href="#">
                                <h3>Base de Datos<span>CD-SUA</span></h3>
								 <p><% Response.Write(NumeroSUA()); %></p><h4>Consultas</h4>
                                </a>
							</div>
							<div class="clearfix"> </div>
						</div>
					</div>
					<div class="col-md-6 ticket-grid">
						<div class="tickets">
							<div class="grid-left">
								<div class="book-icon">
									<i class="fa fa-database"></i>
								</div>
							</div>
							<div class="grid-right">
								<a href="#">
                                <h3>Base de Datos<span>División de Registro y Admin. de Aplicaciones</span></h3>
								<p><% Response.Write(NumeroNivelCentral()); %></p><h4>Consultas</h4>
                                </a>
							</div>
							<div class="clearfix"> </div>
						</div>
					</div>				
					<div class="clearfix"> </div>
				</div>
        </form>

     <!-- input-forms -->
		<script type="text/javascript" src="../esilos_admin/js/valida.2.1.6.min.js"></script>
		<script type="text/javascript" >

		    $(document).ready(function () {

		        // show Valida's version.
		        $('#version').valida('version');

		        // Exemple 1
		        $('.valida').valida();

		        // Exemple 2
		        /*
				$('.valida').valida({

					// basic settings
					validate: 'novalidate',
					autocomplete: 'off',
					tag: 'p',

					// default messages
					messages: {
						submit: 'Wait ...',
						required: 'Este campo é obrigatório',
						invalid: 'Field with invalid data',
						textarea_help: 'Digitados <span class="at-counter">{0}</span> de {1}'
					},

					// filters & callbacks
					use_filter: true,

					// a callback function that will be called right before valida runs.
					// it must return a boolan value (true for good results and false for errors)
					before_validate: null,

					// a callback function that will be called right after valida runs.
					// it must return a boolan value (true for good results and false for errors)
					after_validate: null

				});
				*/
		        // setup the partial validation
		        $('#partial-1').on('click', function (ev) {
		            ev.preventDefault();
		            $('#res-1').click(); // clear form error msgs
		            $('form').valida('partial', '#field-1'); // validate only field-1
		            $('form').valida('partial', '#field-1-3'); // validate only field-1-3
		        });

		    });

		</script>
		<!-- //input-forms -->
		<!--validator js-->
		<script src="../esilos_admin/js/validator.min.js"></script>
		<!--//validator js-->
</asp:Content>

