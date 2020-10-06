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
using System.Net;

public partial class Admin_RptPagosporAnioNC : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = GridView1.SelectedRow;
        string nss = Convert.ToString(GridView1.DataKeys[row.RowIndex].Values["Cve Nss"]);
        string reg = Convert.ToString(GridView1.DataKeys[row.RowIndex].Values["Cve Reg Patronal"]);
        string nom = Convert.ToString(GridView1.DataKeys[row.RowIndex].Values["Nom Trabajador"]);
        Session["Reporte"] = "Pagos_anio";
        Session["Texbox1"] = nss;

        string ClientIP = GetIP4Address();
        string conex1 = ConfigurationManager.ConnectionStrings["Panel_ControlConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conex1);
        String sentencia = "INSERT INTO [Panel_Control].[dbo].[Acciones] ([id_user],[del] ,[sub] ,[tipo] ,[herra] ,[reg], [ip] ,[fecha]) "
        + "VALUES(@id_user,@del ,@sub ,@tipo ,@herra,@reg ,@ip ,@fecha)";
        SqlCommand comando = new SqlCommand(sentencia, con);
        int resultado;
        try
        {
            con.Open();
            comando.Parameters.Add(new SqlParameter("@id_user", SqlDbType.Int));
            comando.Parameters["@id_user"].Value = Request.Cookies["ID"].Value;

            comando.Parameters.Add(new SqlParameter("@del", SqlDbType.NVarChar, 50));
            comando.Parameters["@del"].Value = Request.Cookies["Del"].Value;

            comando.Parameters.Add(new SqlParameter("@sub", SqlDbType.NVarChar, 50));
            comando.Parameters["@sub"].Value = Request.Cookies["Sub"].Value;

            comando.Parameters.Add(new SqlParameter("@tipo", SqlDbType.NVarChar, 50));
            comando.Parameters["@tipo"].Value = "Consulta Año Nivel Central";

            comando.Parameters.Add(new SqlParameter("@herra", SqlDbType.NVarChar, 50));
            comando.Parameters["@herra"].Value = "MOD40";

            comando.Parameters.Add(new SqlParameter("@reg", SqlDbType.NVarChar, 50));
            comando.Parameters["@reg"].Value = nss;

            comando.Parameters.Add(new SqlParameter("@ip", SqlDbType.NVarChar, 50));
            comando.Parameters["@ip"].Value = ClientIP;

            comando.Parameters.Add(new SqlParameter("@fecha", SqlDbType.DateTime));
            comando.Parameters["@fecha"].Value = DateTime.Now;
            resultado = comando.ExecuteNonQuery();
            Response.Write("<script>window.open('Ver.aspx','_blank');</script>");
        }
        catch (System.Exception d)
        {
            //si se produce un error este mensaje nos indica que no se han almacenado los datos
            alert_uno.Visible = true;
            Literal2.Text = "No se guardaron los Datos" + d.Message;
        }
        
    }
    public static string GetIP4Address()
    {
        string IP4Address = String.Empty;

        foreach (IPAddress IPA in Dns.GetHostAddresses(HttpContext.Current.Request.UserHostAddress))
        {
            if (IPA.AddressFamily.ToString() == "InterNetwork")
            {
                IP4Address = IPA.ToString();
                break;
            }
        }

        if (IP4Address != String.Empty)
        {
            return IP4Address;
        }

        foreach (IPAddress IPA in Dns.GetHostAddresses(Dns.GetHostName()))
        {
            if (IPA.AddressFamily.ToString() == "InterNetwork")
            {
                IP4Address = IPA.ToString();
                break;
            }
        }
        return IP4Address;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView1.Visible = true;
    }
    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {
        GridView1.Visible = true;
    }
}