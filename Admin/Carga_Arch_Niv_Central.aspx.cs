using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Collections;
using System.ComponentModel;
using System.IO;
using System.Windows.Forms;
using System.Net;

public partial class Admin_Carga_Arch_Niv_Central : System.Web.UI.Page
{
    string veri;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DropDownList2.Items.Add("-- Seleccione el año --");
            for (int i = DateTime.Now.Year; i >= 2006; i--)
            {
                DropDownList2.Items.Add(i.ToString());
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       // Response.Write("<script language=javascript>alert('" + FileUpload1.PostedFile.ContentType + "');</script>");
        if (DropDownList2.SelectedValue != "-- Seleccione el año --")
        {
            if (DropDownList1.SelectedValue != "00")
            {
                if (FileUpload1.PostedFile.ContentType == "application/vnd.ms-excel" || FileUpload1.PostedFile.ContentType == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
                {
                    try
                    {
                        string fileName = Path.Combine(Server.MapPath("~/Admin/ImportDocument/") + FileUpload1.PostedFile.FileName);
                        FileUpload1.PostedFile.SaveAs(fileName);
                        string conString = "";
                        string ext = Path.GetExtension(FileUpload1.PostedFile.FileName);
                        if (ext.ToLower() == ".xls")
                        {
                            conString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileName + ";Extended Properties=\"Excel 8.0;HDR=No;IMEX=2\""; ;
                        }
                        else if (ext.ToLower() == ".xlsx")
                        {
                            conString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileName + ";Extended Properties=\"Excel 12.0 Xml;HDR=No;IMEX=1\"";
                        }
                        alert_dos.Visible = true;
                        Literal3.Visible = true;
                        Literal3.Text = conString;
                        OleDbConnection origen = default(OleDbConnection);
                        origen = new OleDbConnection(conString);
                        string tabla = "ELIMINAR_TMP_MOD40";
                        string nom = "Verificar";
                        veri = DropDownList1.SelectedValue + Convert.ToString(DropDownList2.SelectedItem);
                        if (vaciar(tabla) == 1)
                        {
                            if (verificar(veri, nom) == 0)
                            {
                                
                               // System.Threading.Thread.Sleep(10000);
                                Llenar(conString, veri);
                                System.IO.File.Delete(fileName);
                                Literal2.Text = "Se Cargo correctamente la información del mes de " + DropDownList1.SelectedItem + " del año " + DropDownList2.SelectedItem;

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
                                    comando.Parameters["@tipo"].Value = "Subir Informacion Nivel Central";

                                    comando.Parameters.Add(new SqlParameter("@herra", SqlDbType.NVarChar, 50));
                                    comando.Parameters["@herra"].Value = "MOD40";

                                    comando.Parameters.Add(new SqlParameter("@reg", SqlDbType.NVarChar, 50));
                                    comando.Parameters["@reg"].Value = veri;

                                    comando.Parameters.Add(new SqlParameter("@ip", SqlDbType.NVarChar, 50));
                                    comando.Parameters["@ip"].Value = ClientIP;

                                    comando.Parameters.Add(new SqlParameter("@fecha", SqlDbType.DateTime));
                                    comando.Parameters["@fecha"].Value = DateTime.Now;
                                    resultado = comando.ExecuteNonQuery();
                                }
                                catch (System.Exception d)
                                {
                                    //si se produce un error este mensaje nos indica que no se han almacenado los datos
                                    alert_uno.Visible = true;
                                    Literal2.Text = "Insert . " + d.Message;
                                }
                                //Response.AppendHeader("Refresh", 4.5 + "; URL=Carga.aspx");
                            }
                            else
                            {
                                alert_uno.Visible = true;
                                Literal2.Text = "Ya Existe Informacion en la <br> Base de Datos del mes de " + DropDownList1.SelectedItem;
                            }
                        }
                    }
                    catch (System.Exception d)
                    {
                        alert_uno.Visible = true;
                        Literal2.Text = "Try inicio. " + d.Message;
                    }
                }
                else
                {
                    alert_uno.Visible = true;
                    Literal2.Text = "Especifica o selecciona un archivo Excel por favor";
                }
            }
            else
            {
                alert_uno.Visible = true;
                Literal2.Text = "Selecciona un mes por favor";
            }
        }
        else
        {
            alert_uno.Visible = true;
            Literal2.Text = "Selecciona un año por favor";
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

    public Int32 Llenar(string cadena, string verificador)
    {
        Int32 valor = 0;
        try
        {
            string conexi = ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ConnectionString;
            SqlConnection conexion_destino = new SqlConnection(conexi);
            try
            {
                
                OleDbConnection origen = default(OleDbConnection);
                origen = new OleDbConnection(cadena);
                OleDbCommand seleccionNa = default(OleDbCommand);
                seleccionNa = new OleDbCommand("SELECT * FROM [Hoja1$]", origen);
                OleDbDataAdapter adaptadorNa = new OleDbDataAdapter();
                adaptadorNa.SelectCommand = seleccionNa;
                DataTable dt = new DataTable();
                DataSet ds1 = new DataSet();
                adaptadorNa.Fill(dt);
                origen.Close();
                conexion_destino.Open();
                SqlBulkCopy importarNa = default(SqlBulkCopy);
                importarNa = new SqlBulkCopy(conexion_destino);
                importarNa.DestinationTableName = "TMP_MOD40";
                importarNa.WriteToServer(dt);//Carga de hojas
            }
            catch(Exception D)
            {
                alert_dos.Visible = true;
                Literal3.Text = "Carga Hoja1$. " + D.Message;
            }

            SqlParameter res;
            SqlCommand Query1 = new SqlCommand("CARGA_MOD40_BASE_NIVEL_CENTRAL", conexion_destino);
            Query1.CommandType = CommandType.StoredProcedure;
            Query1.Parameters.Add("@Cve_Moda", SqlDbType.Float);
            Query1.Parameters["@Cve_Moda"].Value = 40;
            Query1.Parameters.Add("@Verificador", SqlDbType.NVarChar, 255);
            Query1.Parameters["@Verificador"].Value = verificador;
            res = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
            res.Direction = ParameterDirection.ReturnValue;
            Query1.Parameters.Add(res);
            Query1.ExecuteNonQuery();
            conexion_destino.Close();
            valor = Convert.ToInt32(res.Value);            
        }
        catch(Exception e)
        {
            alert_uno.Visible = true;
            Literal2.Text = "Carga a Tabla. " + e.Message;
        }
        return valor;
    }
    public Int32 vaciar(string NomPro)
    {
        string con = ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ConnectionString;
        SqlConnection conexion = new SqlConnection(con);
        conexion.Open();
        SqlParameter resul;
        SqlCommand delete = new SqlCommand(NomPro, conexion);
        delete.CommandType = CommandType.StoredProcedure;
        resul = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
        resul.Direction = ParameterDirection.ReturnValue;
        delete.Parameters.Add(resul);
        delete.ExecuteNonQuery();
        conexion.Close();
        Int32 valor = Convert.ToInt32(resul.Value);
        return valor;
    }
    public Int32 verificar(string verifi, string nom)
    {
        string conn = ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ConnectionString;
        SqlConnection conexi = new SqlConnection(conn);
        conexi.Open();
        SqlParameter contar;
        SqlCommand consulta = new SqlCommand(nom, conexi);
        consulta.CommandType = CommandType.StoredProcedure;
        consulta.Parameters.Add("@Verificador", SqlDbType.NVarChar, 255);
        consulta.Parameters["@Verificador"].Value = verifi;
        contar = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
        contar.Direction = ParameterDirection.ReturnValue;
        consulta.Parameters.Add(contar);
        consulta.ExecuteNonQuery();
        conexi.Close();
        Int32 valor = Convert.ToInt32(contar.Value);
        return valor;
    }
}