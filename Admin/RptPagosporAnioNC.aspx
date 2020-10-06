<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="RptPagosporAnioNC.aspx.cs" Inherits="Admin_RptPagosporAnioNC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <style type="text/css">
        /*El span representa el enlace a la pagina en la que estamos actualmente*/
 
.gridViewPaginacion span {
display:block;
margin:0;
padding:5px;
width:20px;
height:20px;
border-radius:50% 50%;
background:#B1C689;
color:#3743a1;
border: hidden;
}
 
/*Estilo para los enlaces redondos*/
 
.gridViewPaginacion a {
display:block;
text-decoration:none;
margin:0;
padding:5px;
width:20px;
height:20px;
border-radius:50% 50%;
background:#367DEE;
color:#fff;
border: hidden;
}
 
.gridViewPaginacion a:hover {
display:block;
margin:0;
padding:5px;
width:18px;
height:18px;
border-radius:50% 50%;
background:#B1C689;
color:#3743a1;
box-shadow: 0 0 .5em rgba(0, 0, 0, .8);
 border: hidden;
}
.gridViewHeader{
height:35px;
}
 
.gridViewHeader th {
background-color:#435B14;
padding:5px;
border:solid 1px #757575;
color:#fff;
text-align:center; 
font-size:12px;
}
 
/*Redondeamos el borde superior izquierdo de la primera casilla del header*/
 
.gridViewHeader th:first-child {
border-radius:5px 0 0 0;
}
 
/*Y el borde superior derecho de la ultima casilla*/
 
.gridViewHeader th:last-child {
border-radius:0 5px 0 0;
}
 
/*Estilo para los enlaces del header...*/
 
.gridViewHeader th a {
padding:5px;
text-decoration:none;
color:#435B14;
background-color:#a9c673;
border-radius:5px;
}
 
.gridViewHeader th a:hover {
color:#435B14;
background-color:#B1C689;
box-shadow:0 0 .9em rgba(0, 0, 0, .8);
}
    </style>
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
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<div class="grids">
        <div class="progressbar-heading grids-heading">
            <h2>Reporte de Pagos por Año (Base Div. de Reg. y Admon. de App.)</h2>
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
											<%--<label class="col-md-2 control-label">Digite Número de Seguridad Social o Nombre : </label>--%>
											<div class="col-md-12">
												<div class="input-group">							
													<span class="input-group-addon">
														<i class="fa fa-user"></i>
													</span>
													<asp:TextBox ID="TextBox1" CssClass="form-control1" runat="server" placeholder="N.S.S. o Nombre del Trabajador" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
												</div>
											</div>
										</div>
                                    <div class="row panel-title">
                                    <div class="form-group">
                                        <div class="col-md-10">
                                            <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="Consultar" OnClick="Button1_Click"/>
                                            </div>
											</div>
                                    </div>
                                    </form>
							</div>

                                 <div id="alert_uno" class="alert alert-success" role="alert" runat="server" visible="false">
								<strong>Mensaje!</strong> <asp:Literal ID="Literal2" runat="server"></asp:Literal>
							   </div>
                                 
                            <div class="table table-responsive">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="SqlDataSource1" AllowPaging="True" BackColor="White" 
                        BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                        GridLines="Vertical" CssClass="table table-bordered table-responsive" PagerStyle-CssClass="gridViewPaginacion" PageSize="15" Font-Size="12px" Visible="False" 
                        DataKeyNames="Cve Nss,Cve Reg Patronal,Nom Trabajador" 
                        onselectedindexchanged="GridView1_SelectedIndexChanged">
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:BoundField DataField="Cve Nss" HeaderText="Numeró de Seguridad Social" SortExpression="Cve Nss" />
                            <asp:BoundField DataField="Cve Reg Patronal" HeaderText="Registro Patronal" SortExpression="Cve Reg Patronal" />
                            <asp:BoundField DataField="Nom Trabajador" HeaderText="Nombre del Trabajador" SortExpression="Nom Trabajador" />
                            <asp:TemplateField HeaderText="Seleccionar" ItemStyle-HorizontalAlign="Center">
                          <ItemTemplate>                                  
                                    <asp:LinkButton runat="server" CommandName="Select" CausesValidation="false" ><button type="button" class="btn btn-xs btn-success warning_4">Reporte <i class="fa fa-file-pdf-o"></i></button></asp:LinkButton>
                                
                                 <ItemStyle HorizontalAlign="Center" />
                          </ItemTemplate>
                          </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#0000A9" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#000065" />
                          <emptydatatemplate>
                
          <asp:image id="NoDataImage"
            runat="server"/>
                <br />        
            No Hay Registros.  
                
        </emptydatatemplate> 
                    </asp:GridView>
                                </div>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:MOD40ConnectionString %>" 
                        
                        SelectCommand="SELECT DISTINCT [Cve Nss], [Cve Reg Patronal], [Nom Trabajador] FROM MOD40 
                        WHERE ([Nom Trabajador] LIKE '%' + @nombre + '%') OR ([Cve Nss] LIKE '%' + @nombre + '%') ORDER BY [Nom Trabajador] ASC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="TextBox1" Name="nombre" PropertyName="Text" DefaultValue="" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                                       

                                </div>
						</div>
					</div>
					<div class="clearfix"> </div>
				</div>
            </div>
        </div>
    </div>
</asp:Content>

