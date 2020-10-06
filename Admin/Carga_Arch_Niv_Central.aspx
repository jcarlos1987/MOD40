<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterAdmin.master" AutoEventWireup="true" CodeFile="Carga_Arch_Niv_Central.aspx.cs" Inherits="Admin_Carga_Arch_Niv_Central" %>

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
            <ul class="nav nav-second-level collapse">
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
    <!--grids-->
				<div class="grids">
					<div class="progressbar-heading grids-heading">
						<h2>Carga del Archivo de la Base de Datos Nivel Central</h2>
					</div>
					<div class="forms-grids">
						<div class="col-md-12">
                           
							<div class="panel panel-widget">
								<div class="validation-grids widget-shadow" data-example-id="basic-forms"> 
									<div class="input-info">
										<h3>Ingresa los Siguientes Datos:</h3>
									</div>
									<div class="form-body form-body-info">
										<form data-toggle="validator">
                                             <div class="form-group">
											        <label class="col-md-2 control-label">Año :</label>
											        <div class="col-md-12">
												        <div class="input-group">							
													        <span class="input-group-addon">
														        <i class="fa fa-envelope-o"></i>
													        </span>
													        <asp:DropDownList ID="DropDownList2" placeholder="Password" required="" runat="server" class="form-control">
                                                            </asp:DropDownList>
												        </div>
                                                        <div class="help-block with-errors"></div>
											        </div>
                                                 
										        </div>

                                            <div class="form-group">
											        <label class="col-md-2 control-label">Mes :</label>
											        <div class="col-md-12">
												        <div class="input-group">							
													        <span class="input-group-addon">
														        <i class="fa fa-envelope-o"></i>
													        </span>
													           <asp:DropDownList ID="DropDownList1" runat="server"  required="" CssClass="form-control" >
                                                                <asp:ListItem Value=""></asp:ListItem>
                                                                <asp:ListItem Value="01">Enero</asp:ListItem>
                                                                <asp:ListItem Value="02">Febrero</asp:ListItem>
                                                                <asp:ListItem Value="03">Marzo</asp:ListItem>
                                                                <asp:ListItem Value="04">Abril</asp:ListItem>
                                                                <asp:ListItem Value="05">Mayo</asp:ListItem>
                                                                <asp:ListItem Value="06">Junio</asp:ListItem>
                                                                <asp:ListItem Value="07">Julio</asp:ListItem>
                                                                <asp:ListItem Value="08">Agosto</asp:ListItem>
                                                                <asp:ListItem Value="09">Septiembre</asp:ListItem>
                                                                <asp:ListItem Value="10">Octubre</asp:ListItem>
                                                                <asp:ListItem Value="11">Noviembre</asp:ListItem>
                                                                <asp:ListItem Value="12">Diciembre</asp:ListItem>
                                                            </asp:DropDownList>
												        </div><div class="help-block with-errors"></div>
											        </div>
                                                
										        </div>
                                            <div class="form-group">
											        <label class="col-md-2 control-label">Archivo</label>
											        <div class="col-md-12">
												        <div class="input-group">							
													        <span class="input-group-addon">
														        <i class="fa fa-envelope-o"></i>
													        </span>
													        <asp:FileUpload ID="FileUpload1" required="" runat="server" style="font-family: 'Soberana Sans';"
                                                            class="form-control" />
												        </div><div class="help-block with-errors"></div>
											        </div>                                                
										        </div>
											
											<div class="form-group">
                                                <asp:Button ID="Button1" CssClass="btn btn-primary disabled" runat="server" Text="Cargar" onclick="Button1_Click" />
											</div>
                                            <div id="alert_uno" class="alert alert-success" role="alert" runat="server" visible="false">
								<strong>Mensaje!</strong> <asp:Literal ID="Literal2" runat="server"></asp:Literal>
							   </div>
                                            <div id="alert_dos" class="alert alert-success" role="alert" runat="server" visible="false">
								<strong>Mensaje!</strong>  <asp:Literal ID="Literal3" runat="server"></asp:Literal>
							   </div>
                                            
                                           
										</form>
									</div>
								</div>
							</div>

						</div>
						<div class="clearfix"> </div>
					</div>
				</div>

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

