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

public partial class Admin_Ver : System.Web.UI.Page
{
    Int32 pagos;
    Int32 pagos1;
    ReportDocument crystalReport = new ReportDocument();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Reporte"].ToString() == "Retraso_Pagos")
        {
            
            using (SqlConnection scSqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ToString()))
            {                
                SqlParameter contar;
                SqlCommand cmd = new SqlCommand("RETRASO_PAGOS", scSqlConnection);
                cmd.Parameters.Add("@SUB", SqlDbType.NVarChar, 10);
                cmd.Parameters["@SUB"].Value = Session["Procedimiento"];
                cmd.Parameters.Add("@PERIODO", SqlDbType.Float);
                cmd.Parameters["@PERIODO"].Value = Session["anio"];                
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 3600;
                contar = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
                contar.Direction = ParameterDirection.ReturnValue;
                cmd.Parameters.Add(contar);
                Int32 valor = Convert.ToInt32(contar.Value);
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataTable datatable = new DataTable();
                da.Fill(datatable);

                if (Session["anio1"].ToString() == "1")
                {
                    Session["mes1"] = "MES";
                }
                else
                {
                    Session["mes1"] = "MESES";
                }
                crystalReport.Load(Server.MapPath("~/Admin/Reporte_Pagos_Atras.rpt"));
                CrystalDecisions.Shared.ParameterDiscreteValue delegacion = new ParameterDiscreteValue();
                delegacion.Value = Session["Parametro"].ToString();
                CrystalDecisions.Shared.ParameterDiscreteValue numero = new ParameterDiscreteValue();
                numero.Value = Session["anio1"].ToString();
                CrystalDecisions.Shared.ParameterDiscreteValue mes = new ParameterDiscreteValue();
                mes.Value = Session["mes1"].ToString();
                CrystalDecisions.Shared.ParameterDiscreteValue autor = new ParameterDiscreteValue();
                autor.Value = Request.Cookies["Nombre"].Value;
                crystalReport.SetDataSource(datatable);
                crystalReport.Load(Server.MapPath("~/Admin/Reporte_Pagos_Atras.rpt"));
                crystalReport.ParameterFields[0].CurrentValues.Add(delegacion);
                crystalReport.ParameterFields[1].CurrentValues.Add(numero);
                crystalReport.ParameterFields[2].CurrentValues.Add(mes);
                crystalReport.ParameterFields[3].CurrentValues.Add(autor);
                CrystalReportViewer1.ReportSource = crystalReport;
                crystalReport.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, Session["Parametro"].ToString());
            }
        }
        if (Session["Reporte"].ToString() == "Pagos")
        {
            using (SqlConnection scSqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ToString()))
            {
                SqlParameter contar;
                SqlCommand cmd = new SqlCommand("CONSUL_MOD40", scSqlConnection);
                cmd.Parameters.Add("@NSS", SqlDbType.NVarChar, 255);
                cmd.Parameters["@NSS"].Value = Session["Texbox"];
                cmd.CommandType = CommandType.StoredProcedure;
                contar = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
                contar.Direction = ParameterDirection.ReturnValue;
                cmd.Parameters.Add(contar);
                Int32 valor = Convert.ToInt32(contar.Value);
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataTable datatable = new DataTable();
                da.Fill(datatable); // getting value according to imageID and fill datase               
                CrystalDecisions.Shared.ParameterDiscreteValue vigente = new ParameterDiscreteValue();
                string conexion5 = ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(conexion5);
                SqlCommand command = new SqlCommand("SELECT COUNT([Nom Trabajador])  FROM [MOD40].[dbo].[Reporte] WHERE REPLACE(nss,'-','') ='" + Session["Texbox"] + "'", conn);
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
                if (pagos == 0)
                {
                    Session["vigente"] = "El Asegurado NO esta Vigente en el Afil-67";
                }
                else
                {
                    if (pagos > 1 )
                    {
                        Session["vigente"] = "El Asegurado esta Vigente en el Afil-67";
                    }
                }
                vigente.Value = Session["vigente"].ToString();
                CrystalDecisions.Shared.ParameterDiscreteValue autor = new ParameterDiscreteValue();
                autor.Value = Request.Cookies["Nombre"].Value;
                crystalReport.Load(Server.MapPath("~/Admin/Reporte.rpt")); // path of report 
                crystalReport.SetDataSource(datatable);
                crystalReport.ParameterFields[0].CurrentValues.Add(vigente);
                crystalReport.ParameterFields[1].CurrentValues.Add(autor);
                CrystalReportViewer1.ReportSource = crystalReport;
                crystalReport.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, Session["Texbox"].ToString());
            }
        }
        if (Session["Reporte"].ToString() == "Pagos_anio")
        {
            using (SqlConnection scSqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ToString()))
            {
                SqlParameter contar;
                SqlCommand cmd = new SqlCommand("MOD40_ANIO", scSqlConnection);
                cmd.Parameters.Add("@NSS", SqlDbType.NVarChar, 255);
                cmd.Parameters["@NSS"].Value = Session["Texbox1"];
                cmd.CommandType = CommandType.StoredProcedure;
                contar = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
                contar.Direction = ParameterDirection.ReturnValue;
                cmd.Parameters.Add(contar);
                Int32 valor = Convert.ToInt32(contar.Value);
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataTable datatable = new DataTable();
                da.Fill(datatable);               
                CrystalDecisions.Shared.ParameterDiscreteValue Vigente = new ParameterDiscreteValue();
                string conexion5 = ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(conexion5);
                SqlCommand command = new SqlCommand("SELECT COUNT([movt])  FROM [MOD40].[dbo].[RtpAnio] ", conn);
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        pagos1 = reader.GetInt32(0);
                    }
                }
                conn.Close();
                if (pagos1 == 0)
                {
                    Session["vigente1"] = "El Asegurado NO esta Vigente en el Afil-67";
                }
                else
                {
                    if (pagos1 > 0)
                    {
                        Session["vigente1"] = "El Asegurado esta Vigente en el Afil-67";
                    }
                }
                Vigente.Value = Session["vigente1"].ToString();
                CrystalDecisions.Shared.ParameterDiscreteValue autor = new ParameterDiscreteValue();
                autor.Value = Request.Cookies["Nombre"].Value;
                crystalReport.Load(Server.MapPath("~/Admin/Report.rpt"));
                crystalReport.SetDataSource(datatable);
                crystalReport.ParameterFields[0].CurrentValues.Add(Vigente);
                crystalReport.ParameterFields[1].CurrentValues.Add(autor);
                CrystalReportViewer1.ReportSource = crystalReport;
                crystalReport.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, Session["Texbox1"].ToString());
            }
        }

        if (Session["Reporte"].ToString() == "Periodo")
        {
            using (SqlConnection scSqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ToString()))
            {
                SqlParameter contar;
                SqlCommand cmd = new SqlCommand("RPT_PERIODO", scSqlConnection);
                cmd.Parameters.Add("@NSS", SqlDbType.NVarChar, 255);
                cmd.Parameters["@NSS"].Value = Session["NssPerio"];
                cmd.CommandType = CommandType.StoredProcedure;
                contar = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
                contar.Direction = ParameterDirection.ReturnValue;
                cmd.Parameters.Add(contar);
                Int32 valor = Convert.ToInt32(contar.Value);
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataTable datatable = new DataTable();
                da.Fill(datatable);                
                CrystalDecisions.Shared.ParameterDiscreteValue Vigente = new ParameterDiscreteValue();
                string conexion5 = ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(conexion5);
                SqlCommand command = new SqlCommand("SELECT COUNT([movt])  FROM [MOD40].[dbo].[Rtp_periodo] ", conn);
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        pagos1 = reader.GetInt32(0);
                    }
                }
                conn.Close();
                if (pagos1 == 0)
                {
                    Session["vigente1"] = "El Asegurado NO esta Vigente en el Afil-67";
                }
                else
                {
                    if (pagos1 > 0)
                    {
                        Session["vigente1"] = "El Asegurado esta Vigente en el Afil-67";
                    }
                }
                Vigente.Value = Session["vigente1"].ToString();
                CrystalDecisions.Shared.ParameterDiscreteValue autor = new ParameterDiscreteValue();
                autor.Value = Request.Cookies["Nombre"].Value;
                crystalReport.Load(Server.MapPath("~/Admin/Perio.rpt"));
                crystalReport.SetDataSource(datatable);
                crystalReport.ParameterFields[0].CurrentValues.Add(Vigente);
                crystalReport.ParameterFields[1].CurrentValues.Add(autor);
                CrystalReportViewer1.ReportSource = crystalReport;
                crystalReport.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, Session["NssPerio"].ToString());
            }
        }

 
    }
    protected void CrystalReportViewer1_Unload(object sender, EventArgs e)
    {
        crystalReport.Close();
        CrystalReportViewer1.Dispose();
        crystalReport.Dispose();
    }
}