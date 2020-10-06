using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public partial class Admin_Default : System.Web.UI.Page
{
    string conexion5 = ConfigurationManager.ConnectionStrings["Panel_ControlConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public int NumeroNivelCentral ()
    {
        Int32 count = 0;
        SqlConnection conn = new SqlConnection(conexion5);
        conn.Open();
        SqlCommand comm = new SqlCommand(@"SELECT COUNT(*) FROM [Panel_Control].[dbo].[Acciones] WHERE herra='MOD40' AND tipo 
                                            IN('Consulta Pagos Realizados Nivel Central','Consulta Año Nivel Central','Consulta Pagos Periodo Nivel Central','Consulta Pagos Omitidos Nivel Central')", conn);
        count = (Int32)comm.ExecuteScalar();
        conn.Close();
        return count;
    }

    public int NumeroSUA()
    {
        Int32 count = 0;
        SqlConnection conn = new SqlConnection(conexion5);
        conn.Open();
        SqlCommand comm = new SqlCommand(@"SELECT COUNT(*) FROM [Panel_Control].[dbo].[Acciones] WHERE herra='MOD40' AND tipo 
                                           IN('Consulta Pagos Realizados CDSUA','Consulta Año CDSUA','Consulta Pagos Periodo CDSUA','Consulta Pagos Omitidos CDSUA')", conn);
        count = (Int32)comm.ExecuteScalar();
        conn.Close();
        return count;
    }
}