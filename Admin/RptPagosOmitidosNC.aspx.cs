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

public partial class Admin_RptPagosOmitidos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string value = ConfigurationManager.AppSettings["sub"].ToString();
            string text = ConfigurationManager.AppSettings["sub_nom"].ToString();            
            string[] value1 = value.Split(',');
            string[] text1 = text.Split(',');
            value = ConfigurationManager.AppSettings["Delegacion"].ToString();
            text = ConfigurationManager.AppSettings["DelegacionNom"].ToString();
            string[] value2 = value.Split(',');
            string[] text2 = text.Split(',');
            for (int i = 0; i < text1.Length; i++)
            {
                ListItem li = new ListItem(text1[i], value1[i]);
                DropDownList2.Items.Add(li);
            }
            for (int i = 0; i < text2.Length; i++)
            {
                ListItem li = new ListItem(text2[i], value2[i]);
                DropDownList2.Items.Add(li);
            }
            try
            {
                if (Request.Cookies["Tipo"].Value == "1" || Request.Cookies["Tipo"].Value == "2" || Request.Cookies["Tipo"].Value == "3")
                {
                    this.DropDownList1.Items.Insert(1, new ListItem("1", "-1"));
                    this.DropDownList1.Items.Insert(2, new ListItem("2", "-2"));
                    this.DropDownList1.Items.Insert(3, new ListItem("3", "-3"));
                    this.DropDownList1.Items.Insert(4, new ListItem("4", "-4"));
                    this.DropDownList1.Items.Insert(5, new ListItem("5", "-5"));
                    this.DropDownList1.Items.Insert(6, new ListItem("6", "-6"));
                    this.DropDownList1.Items.Insert(7, new ListItem("7", "-7"));
                    this.DropDownList1.Items.Insert(8, new ListItem("8", "-8"));
                    this.DropDownList1.Items.Insert(9, new ListItem("9", "-9"));
                    this.DropDownList1.Items.Insert(10, new ListItem("10", "-10"));
                    this.DropDownList1.Items.Insert(11, new ListItem("11", "-11"));
                    this.DropDownList1.Items.Insert(12, new ListItem("12", "-12"));
                }
                else if (Request.Cookies["Tipo"].Value == "0")
                {
                    this.DropDownList1.Items.Insert(1, new ListItem("1", "-1"));
                    this.DropDownList1.Items.Insert(2, new ListItem("2", "-2"));
                    this.DropDownList1.Items.Insert(3, new ListItem("3", "-3"));
                    this.DropDownList1.Items.Insert(4, new ListItem("4", "-4"));
                    this.DropDownList1.Items.Insert(5, new ListItem("5", "-5"));
                    this.DropDownList1.Items.Insert(6, new ListItem("6", "-6"));
                    this.DropDownList1.Items.Insert(7, new ListItem("7", "-7"));
                    this.DropDownList1.Items.Insert(8, new ListItem("8", "-8"));
                    this.DropDownList1.Items.Insert(9, new ListItem("9", "-9"));
                    this.DropDownList1.Items.Insert(10, new ListItem("10", "-10"));
                    this.DropDownList1.Items.Insert(11, new ListItem("11", "-11"));
                    this.DropDownList1.Items.Insert(12, new ListItem("12", "-12"));
                    this.DropDownList1.Items.Insert(13, new ListItem("Acumulativo", "-13"));
                }
            }
            catch (Exception ex)
            {
                //throw ex;
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (DropDownList2.SelectedValue != "00")
        {
            if (DropDownList1.SelectedValue != "00")
            {
               // Literal2.Text = DropDownList2.SelectedValue;
                if (DropDownList2.SelectedValue != "")
                {
                    Literal2.Text = DropDownList2.SelectedValue;
                    Session["anio1"] = DropDownList1.SelectedItem;
                    Session["anio"] = DropDownList1.SelectedValue;
                    Session["Procedimiento"] = DropDownList2.SelectedValue;
                    Session["Parametro"] = DropDownList2.SelectedItem;
                    Session["Reporte"] = "Retraso_Pagos";
                    alert_uno.Visible = false;
                    Literal2.Visible = false;
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
                        comando.Parameters["@tipo"].Value = "Consulta Pagos Omitidos Nivel Central";

                        comando.Parameters.Add(new SqlParameter("@herra", SqlDbType.NVarChar, 50));
                        comando.Parameters["@herra"].Value = "MOD40";

                        comando.Parameters.Add(new SqlParameter("@reg", SqlDbType.NVarChar, 50));
                        comando.Parameters["@reg"].Value = Convert.ToString(DropDownList2.SelectedItem) + '/' + Convert.ToString(DropDownList1.SelectedItem);

                        comando.Parameters.Add(new SqlParameter("@ip", SqlDbType.NVarChar, 50));
                        comando.Parameters["@ip"].Value = ClientIP;

                        comando.Parameters.Add(new SqlParameter("@fecha", SqlDbType.Date));
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
                else
                {
                    Literal2.Text = "No se gua";
                }
            }
            else
            {
                alert_uno.Visible = true;
                Literal2.Text = "Selecciona al Año de Retraso";
            }            
        }
        else
        {
            alert_uno.Visible = true;
            Literal2.Text = "Selecciona el tipo de Reporte";
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
}