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
//using System.Windows.Forms;
using Ionic.Zip;
using amfwinrar;
using System.Net;

public partial class Admin_Carga_CD_SUA : System.Web.UI.Page
{ /*Declaraciones de Variables Globales */
    string file1;
    string file2;
    string vir_as;
    string vir_pat;
    string tab_As;
    string tab_Pat;
    string carga;
    string Ext_Ase;
    string Ext_Pat;
    string Borrar_nss;
    string Borrar_p;
    string Borrar_pesos;
    string Total;
    string Elim_Ase;
    string Elim_Pat;
    string verificar_pro;
    string Tot_Ase;
    string Tot_Pat;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            /*agrega datos a la lista desplegable*/
            DropDownList2.Items.Add("");
            for (int i = DateTime.Now.Year; i >= 1997; i--)
            {
                DropDownList2.Items.Add(i.ToString());
            }
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        /*Evalua si han seleccionado un año*/
        if (DropDownList2.SelectedValue != "")
        {
            /*Evalua si han seleccionado un mes*/
            if (DropDownList1.SelectedValue != "")
            {
                /*Evalua si han seleccionado un archivo*/
                if (FileUpload1.HasFile)
                {
                    /*Evalua que el archivo seleccionado es un archivo .zip*/
                    if (FileUpload1.PostedFile.ContentType == "application/x-zip-compressed" || FileUpload1.PostedFile.ContentType == "application/octet-stream" || FileUpload1.PostedFile.ContentType == "application/zip")
                    {
                        try
                        {
                            /*Obtiene Ruta virtual de las carpetas donde se sube el archivo */
                            string ruta = Path.Combine(Server.MapPath("~/Admin/ImportDocument/"));
                            /*Obtiene Ruta virtual de las carpetas donde se sube el archivo mas el nombre del archivo */
                            string fileName = Path.Combine(Server.MapPath("~/Admin/ImportDocument/") + FileUpload1.PostedFile.FileName);
                            /*Almacena el archivo en la ruta especificada */
                            FileUpload1.PostedFile.SaveAs(fileName);
                            /*Si el archivo es .zip */
                            if (FileUpload1.PostedFile.ContentType == "application/x-zip-compressed" || FileUpload1.PostedFile.ContentType == "application/octet-stream" || FileUpload1.PostedFile.ContentType == "application/zip")
                            {
                                try
                                {
                                    /*Extraccion de los archivos */
                                    using (ZipFile zip = ZipFile.Read(fileName))
                                    {
                                        zip.ExtractAll(ruta);
                                        zip.Dispose();
                                    }
                                }
                                catch (System.Exception d)
                                {
                                    alert_uno.Visible = true;
                                    Literal2.Text = "Error reading from {0}. Message = {1}" + d.Message;
                                }
                            }
                            else
                            {
                                /*Si el archivo es .rar */
                                if (FileUpload1.PostedFile.ContentType == "application/octet-stream")
                                {
                                    try
                                    {
                                        using (ZipFile zip = ZipFile.Read(fileName))
                                        {
                                            /*Extraccion de los archivos */
                                            zip.ExtractAll(ruta);
                                            zip.Dispose();
                                        }
                                    }
                                    catch (System.Exception d)
                                    {
                                        alert_uno.Visible = true;
                                        Literal2.Text = "Error reading from {0}. Message = {1}" + d.Message;
                                    }
                                }
                            }
                            /*Elimina el archivo .zip */
                            System.IO.File.Delete(fileName);
                            /*Obtiene el nombre de los archivos y extrae nombres con su extension */
                            DirectoryInfo oDirectorio = new DirectoryInfo(ruta);
                            FileInfo[] files = oDirectorio.GetFiles("*.*");
                            foreach (FileInfo file in oDirectorio.GetFiles())
                            {
                                for (int i = 0; i < files.Length; i++)
                                {
                                    file1 = ((FileInfo)files[0]).FullName;
                                    file2 = ((FileInfo)files[1]).FullName;
                                }
                            }
                            /*Extraccion extension de los archivos */
                            string ext = Path.GetExtension(file1);
                            string ext1 = Path.GetExtension(file2);
                            string conString1 = "";
                            string conString2 = "";
                            /*Extraccion nombre de los archivos y extension */
                            string result = Path.GetFileName(file1);
                            string result1 = Path.GetFileName(file2);
                            //Response.Write("<script language=javascript>alert('" + result + "');</script>");
                            /*Compara que los nombres de los archivos sean los correctos*/
                            if (result.ToUpper() == "CDSU1601.MDB" && result1.ToUpper() == "CDSU1605.MDB")
                            {
                                /*Extraccion de la información  */
                                //Access 2007
                                if (ext.ToLower() == ".mdb")
                                {
                                    /*Extraccion de la información de toluca*/
                                    conString1 = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + file1 + ";Persist Security Info=False";
                                }
                                if (ext1.ToLower() == ".mdb")
                                {
                                    /*Extraccion de la información de naucalpan */
                                    conString2 = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + file2 + ";Persist Security Info=False";
                                }
                                /*Extraccion de la información  */
                                //Access 2010 en adelante
                                if (ext.ToLower() == ".accdb")
                                {
                                    /*Extraccion de la información de toluca*/
                                    conString1 = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + file1 + ";Persist Security Info=False";
                                }
                                if (ext1.ToLower() == ".accdb")
                                {
                                    /*Extraccion de la información de naucalpan */
                                    conString2 = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + file2 + ";Persist Security Info=False";
                                }

                                /*digito verificador de carga segun el mes y año  */
                                carga = DropDownList1.SelectedValue + Convert.ToString(DropDownList2.SelectedItem);
                                /*Verifica si hay registros cargados en la Base de Datos */
                                if (verificar(carga, "VERIFICACION_REGISTROS") == 0)
                                {
                                    //Carga Toluca
                                    //Asegurados
                                    Procedimientos("ELIMINAR_ASEGURADOS");
                                    Procedimientos("ELIMINAR_PATRONES");
                                    Cargar_TMP(conString1, carga, "CDSUAS", "CDSUAS_TMP");
                                    //Patrones
                                    Cargar_TMP(conString1, carga, "CDSUPA", "CDSUPA_TMP");
                                    //Carga Naucalpan
                                    //Asegurados
                                    Cargar_TMP(conString2, carga, "CDSUAS", "CDSUAS_TMP");
                                    //Patrones
                                    Cargar_TMP(conString2, carga, "CDSUPA", "CDSUPA_TMP");
                                    /*Ejecuta procedimientos almacenados de extraccion de patrones, asegurados,elimina N de asegurados, elimina la p de patrones
                                     * elimina signo de pesos de asegurados y realiza la carga a las tablas finales*/
                                    Procedimientos("EXTRACCION_PATRONES");
                                    Procedimientos("EXTRACCION_ASEGURADOS");
                                    Procedimientos("BORRAR_CARACTER_NSS");
                                    Procedimientos("BORRAR_CARACTER_PATRONAL");
                                    Procedimientos("BORRAR_SIGNO_PESOS_NOMBRE");
                                    Carga_Total(carga, "CARGA_CDSUA");
                                    /*Elimina ambos archivos de access*/
                                    System.IO.File.Delete(file1);
                                    System.IO.File.Delete(file2);
                                    /*Ejecuta procedimiento deconteo de registros cargados*/
                                    Int32 Tot_Asegurados = verificar(carga, "REGISTROS_CARGADOS_ASEGURADOS");
                                    Int32 Tot_Patrones = verificar(carga, "REGISTROS_CARGADOS_PATRONES");

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
                                        comando.Parameters["@tipo"].Value = "Subir Informacion CDSUA";

                                        comando.Parameters.Add(new SqlParameter("@herra", SqlDbType.NVarChar, 50));
                                        comando.Parameters["@herra"].Value = "MOD40";

                                        comando.Parameters.Add(new SqlParameter("@reg", SqlDbType.NVarChar, 50));
                                        comando.Parameters["@reg"].Value = carga;

                                        comando.Parameters.Add(new SqlParameter("@ip", SqlDbType.NVarChar, 50));
                                        comando.Parameters["@ip"].Value = ClientIP;

                                        comando.Parameters.Add(new SqlParameter("@fecha", SqlDbType.NVarChar, 50));
                                        comando.Parameters["@fecha"].Value = DateTime.Now.ToString("yyyy/M/dd hh:mm:ss");
                                        resultado = comando.ExecuteNonQuery();
                                    }
                                    catch (System.Exception d)
                                    {
                                        //si se produce un error este mensaje nos indica que no se han almacenado los datos
                                        alert_uno.Visible = true;
                                        Literal2.Text = "No se guardaron los Datos" + "Error reading from {0}. Message = {1}" + d.Message;
                                    }


                                    /*Muestra mensajes sobre que mes se cargo informacion y cuantos registros se cargaron */
                                    alert_uno.Visible = true;
                                    alert_dos.Visible = true;
                                    Literal2.Text = "Se Cargo correctamente la información del mes de " + DropDownList1.SelectedItem + " del año " + DropDownList2.SelectedItem;
                                    Literal3.Text = "Se Cargaron " + Tot_Asegurados + " Asegurados <br>" + "Se cargaron " + Tot_Patrones + " Patrones";
                                    //Response.AppendHeader("Refresh", 8.5 + "; URL=CargaCDSUA.aspx");
                                }
                                else
                                {
                                    alert_uno.Visible = true;
                                    Literal2.Text = "Ya Existe Informacion en la <br> Base de Datos del mes de " + DropDownList1.SelectedItem;
                                    System.IO.File.Delete(file1);
                                    System.IO.File.Delete(file2);
                                }
                            }
                            else
                            {
                                alert_uno.Visible = true;
                                Literal2.Text = "El archivo " + result + " y " + result1 + " no son los correctos. <br> Suba los correctos por favor";
                                System.IO.File.Delete(file1);
                                System.IO.File.Delete(file2);
                            }
                        }

                        catch (System.Exception d)
                        {
                            alert_dos.Visible = true;
                            Literal3.Text = "Las Bases de Datos no son las correctas. Selecciona las Correctas por Favor" + d.Message;
                            System.IO.File.Delete(file1);
                            System.IO.File.Delete(file2);
                        }
                    }
                    else
                    {
                        alert_uno.Visible = true;
                        Literal2.Text = "El archivo debe ser .zip";
                    }
                }
                else
                {
                    alert_uno.Visible = true;
                    Literal2.Text = "Especifica o selecciona un archivo por favor";
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
    /*Funcion que realiza la carga total de las bases de datos de access a SQL SERVER y Devuleve un valor entero*/
    public Int32 Cargar_TMP(string cadena, string verificador, string virt, string tabla)
    {
        string conexi = ConfigurationManager.ConnectionStrings["MOD40_CDSUAConnectionString"].ConnectionString;
        SqlConnection conexion_destino = new SqlConnection(conexi);
        OleDbConnection origen = default(OleDbConnection);
        origen = new OleDbConnection(cadena);
        DataSet myDataSet = new DataSet();
        var myAdapptor = new OleDbDataAdapter();
        OleDbCommand command = new OleDbCommand("SELECT * FROM  " + virt + verificador, origen);
        myAdapptor.SelectCommand = command;
        myAdapptor.Fill(myDataSet, virt);
        conexion_destino.Open();
        SqlBulkCopy importarNa = default(SqlBulkCopy);
        importarNa = new SqlBulkCopy(conexion_destino);
        importarNa.DestinationTableName = tabla;
        importarNa.WriteToServer(myDataSet.Tables[0]);//Carga de hojas
        Int32 valor = 1;
        return valor;
    }
    /*Funcion que ejecuta cada uno de los procedimientos que se ejecutan  y Devuleve un valor entero*/
    public Int32 Procedimientos(string NomPro)
    {
        string con = ConfigurationManager.ConnectionStrings["MOD40_CDSUAConnectionString"].ConnectionString;
        SqlConnection conexion = new SqlConnection(con);
        conexion.Open();
        SqlParameter resul;
        SqlCommand delete = new SqlCommand(NomPro, conexion);
        delete.CommandType = CommandType.StoredProcedure;
        delete.CommandTimeout = 3600;
        resul = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
        resul.Direction = ParameterDirection.ReturnValue;
        delete.Parameters.Add(resul);
        delete.ExecuteNonQuery();
        conexion.Close();
        Int32 valor = Convert.ToInt32(resul.Value);
        return valor;
    }
    /*Funcion que ejecuta la verificacion de registros por subdelegacion  y Devuleve un valor entero*/
    public Int32 verificar(string verifi, string nom)
    {
        string conn = ConfigurationManager.ConnectionStrings["MOD40_CDSUAConnectionString"].ConnectionString;
        SqlConnection conexi = new SqlConnection(conn);
        conexi.Open();
        SqlParameter contar;
        SqlCommand consulta = new SqlCommand(nom, conexi);
        consulta.CommandType = CommandType.StoredProcedure;
        consulta.CommandTimeout = 3600;
        consulta.Parameters.Add("@PERIODO", SqlDbType.NVarChar, 255);
        consulta.Parameters["@PERIODO"].Value = verifi;
        contar = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
        contar.Direction = ParameterDirection.ReturnValue;
        consulta.Parameters.Add(contar);
        consulta.ExecuteNonQuery();
        conexi.Close();
        Int32 valor = Convert.ToInt32(contar.Value);
        return valor;
    }
    /*Funcion la cual realiza la carga de registros a las tablas finales asignando el periodo de auerdo al mes y año 
      y Devuleve un valor entero*/
    public Int32 Carga_Total(string verifi, string nom)
    {
        string conn = ConfigurationManager.ConnectionStrings["MOD40_CDSUAConnectionString"].ConnectionString;
        SqlConnection conexi = new SqlConnection(conn);
        conexi.Open();
        SqlParameter contar;
        SqlCommand consulta = new SqlCommand(nom, conexi);
        consulta.CommandType = CommandType.StoredProcedure;
        consulta.CommandTimeout = 3600;
        consulta.Parameters.Add("@PERIODO", SqlDbType.NVarChar, 255);
        consulta.Parameters["@PERIODO"].Value = verifi;
        contar = new SqlParameter("RETURN_VALUE", SqlDbType.Int);
        contar.Direction = ParameterDirection.ReturnValue;
        consulta.Parameters.Add(contar);
        consulta.ExecuteNonQuery();
        conexi.Close();
        Int32 valor = Convert.ToInt32(contar.Value);
        return valor;
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