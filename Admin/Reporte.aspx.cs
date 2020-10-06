using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.Drawing.Printing;
using System.Text;
using System.Data.OleDb;
using CrystalDecisions.ReportSource;
using CrystalDecisions.Web;
using System.Windows.Forms; 

public partial class Admin_Reporte : System.Web.UI.Page   
{
    Int32 pagos;
    ReportDocument crystalReport = new ReportDocument();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Tipo_Reporte"].ToString() == "Pagos")
        {
            using (SqlConnection scSqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MOD40_CDSUAConnectionString"].ToString()))
            {    
                DataTable dt = ((DataView)CONSUL_NUMERO_PAGOS_NSS.Select(DataSourceSelectArguments.Empty)).Table;
                dt.TableName = "ConNSS";
                CrystalDecisions.Shared.ParameterDiscreteValue vigente = new ParameterDiscreteValue();
                CrystalDecisions.Shared.ParameterDiscreteValue usuario = new ParameterDiscreteValue();
                string conexion5 = ConfigurationManager.ConnectionStrings["MOD40_CDSUAConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(conexion5);
                SqlCommand command = new SqlCommand("SELECT COUNT([iden_trabaj])  FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos] WHERE [RCAS_NUM_AFIL] ='" + Session["nss_pagos"] + "'", conn);
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        pagos = reader.GetInt32(0);
                    }
                }
                conn.Close();
                vigente.Value = FnVigente(pagos);
                usuario.Value = Request.Cookies["Nombre"].Value;
                crystalReport.Load(Server.MapPath("~/Admin/Numero_Pag.rpt")); // path of report 
                crystalReport.SetDataSource(dt);
                crystalReport.ParameterFields[0].CurrentValues.Add(vigente);
                crystalReport.ParameterFields[1].CurrentValues.Add(usuario);
                CrystalReportViewer1.ReportSource = crystalReport;
                crystalReport.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, Session["nss_pagos"].ToString());
            }
        }
        if (Session["Tipo_Reporte"].ToString() == "PagosxPeriodo")
        {
            using (SqlConnection scSqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MOD40_CDSUAConnectionString"].ToString()))
            {
                DataTable dt = ((DataView)CONSULTA_PAGOS_X_PERIODO.Select(DataSourceSelectArguments.Empty)).Table;
                dt.TableName = "CDSUA_periodo";
                CrystalDecisions.Shared.ParameterDiscreteValue vigente = new ParameterDiscreteValue();
                CrystalDecisions.Shared.ParameterDiscreteValue usuario = new ParameterDiscreteValue();
                string conexion5 = ConfigurationManager.ConnectionStrings["MOD40_CDSUAConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(conexion5);
                SqlCommand command = new SqlCommand("SELECT COUNT([iden_trabaj])  FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos] WHERE [RCAS_NUM_AFIL] ='" + Session["nss_pagos"] + "'", conn);
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        pagos = reader.GetInt32(0);
                    }
                }
                conn.Close();                
                vigente.Value = FnVigente(pagos);
                usuario.Value = Request.Cookies["Nombre"].Value;
                crystalReport.Load(Server.MapPath("~/Admin/CrystalReport1.rpt")); // path of report 
                crystalReport.SetDataSource(dt);
                crystalReport.ParameterFields[0].CurrentValues.Add(vigente);
                crystalReport.ParameterFields[1].CurrentValues.Add(usuario);
                CrystalReportViewer1.ReportSource = crystalReport;
                crystalReport.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, Session["nss_pagos"].ToString());
            }
        }
        if (Session["Tipo_Reporte"].ToString() == "Pagosxanio")
        {
            using (SqlConnection scSqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MOD40_CDSUAConnectionString"].ToString()))
            {
                DataTable dt = ((DataView)CONSULTA_PAGOS_X_ANIO.Select(DataSourceSelectArguments.Empty)).Table;
                dt.TableName = "CDSUA_Anio";
                CrystalDecisions.Shared.ParameterDiscreteValue vigente = new ParameterDiscreteValue();
                CrystalDecisions.Shared.ParameterDiscreteValue usuario = new ParameterDiscreteValue();
                string conexion5 = ConfigurationManager.ConnectionStrings["MOD40_CDSUAConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(conexion5);
                SqlCommand command = new SqlCommand("SELECT COUNT([salario_BC])  FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_ANIO] WHERE [RCAS_NUM_AFIL] ='" + Session["nss_pagos"] + "'", conn);
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        pagos = reader.GetInt32(0);
                    }
                }
                conn.Close();
             
                vigente.Value = FnVigente(pagos); 
                usuario.Value = Request.Cookies["Nombre"].Value;
                crystalReport.Load(Server.MapPath("~/Admin/CrystalReport2.rpt")); // path of report 
                crystalReport.SetDataSource(dt);
                crystalReport.ParameterFields[0].CurrentValues.Add(vigente);
                crystalReport.ParameterFields[1].CurrentValues.Add(usuario);
                CrystalReportViewer1.ReportSource = crystalReport;
                crystalReport.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, Session["nss_pagos"].ToString());
            }
        }

        if (Session["Tipo_Reporte"].ToString() == "Retraso_Pagos")
        {
            using (SqlConnection scSqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MOD40_CDSUAConnectionString"].ToString()))
            {
                DataTable dt = ((DataView)RTP_PAGOS_RETRASADOS.Select(DataSourceSelectArguments.Empty)).Table;
                dt.TableName = "RTP_CDSUA_ATRAS";
                if (Session["anio1"].ToString() == "1")
                {
                    Session["mes1"] = "MES";
                }
                else
                {
                    Session["mes1"] = "MESES";
                }
                crystalReport.Load(Server.MapPath("~/Admin/CrystalReport3.rpt"));
                CrystalDecisions.Shared.ParameterDiscreteValue delegacion = new ParameterDiscreteValue();
                delegacion.Value = Session["Parametro"].ToString();
                CrystalDecisions.Shared.ParameterDiscreteValue numero = new ParameterDiscreteValue();
                numero.Value = Session["anio1"].ToString();
                CrystalDecisions.Shared.ParameterDiscreteValue mes = new ParameterDiscreteValue();
                mes.Value = Session["mes1"].ToString();
                CrystalDecisions.Shared.ParameterDiscreteValue autor = new ParameterDiscreteValue();
                autor.Value = Request.Cookies["Nombre"].Value;
                crystalReport.SetDataSource(dt);            
                crystalReport.ParameterFields[0].CurrentValues.Add(delegacion);
                crystalReport.ParameterFields[1].CurrentValues.Add(numero);
                crystalReport.ParameterFields[2].CurrentValues.Add(mes);
                crystalReport.ParameterFields[3].CurrentValues.Add(autor);
                CrystalReportViewer1.ReportSource = crystalReport;
                crystalReport.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, Session["Parametro"].ToString());
            }
        }
    }

    public static string FnVigente(int valor)
    {
        string status = "";
        if (valor == 0)
        {
            status = "El Asegurado NO esta Vigente en el Afil-67";
        }
        else if (valor >= 1)
        {
            status = "El Asegurado esta Vigente en el Afil-67";
        }
        return status;
    }
    protected void CrystalReportViewer1_Unload(object sender, EventArgs e)
    {
        crystalReport.Close();
        CrystalReportViewer1.Dispose();
        crystalReport.Dispose();
    }
}