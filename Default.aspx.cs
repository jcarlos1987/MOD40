using System;
using System.Collections.Generic;
using System.Linq;
//Librerias
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Configuration;
public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
   }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //Configuracion de Cadena de conexion
        string conexion5 = ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ConnectionString;
        SqlConnection conn = new SqlConnection(conexion5);
        try
        {
            //Consulta para la busqueda del usuario dentro del la BD con los datos que se requieren del usuario
            SqlCommand command = new SqlCommand("SELECT T1.[id], T2.[nombre], T1.[del], T1.[sub], [user_type], [cargo],[depto] FROM [MOD40].[dbo].[User] T1 INNER JOIN [Panel_Control].[dbo].[Usuarios] T2 ON T1.[id]=T2.[id] WHERE T2.[user]='" + inputusuario.Text + "' AND T2.[pass]='" + inputPassword.Text + "' AND T1.[id]=T2.[id]", conn);
            conn.Open();
            //ejecucion de la consulta
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    //Asignacion de variables a cookies
                    Int32 id = reader.GetInt32(0);
                    Response.Cookies["ID"].Value = Convert.ToString(id);
                    Response.Cookies["Nombre"].Value = string.Format(reader.GetString(1));
                    Response.Cookies["Del"].Value = string.Format(reader.GetString(2));
                    Response.Cookies["Sub"].Value = string.Format(reader.GetString(3));
                    Response.Cookies["Tipo"].Value = string.Format(reader.GetString(4));
                    Response.Cookies["Cargo"].Value = string.Format(reader.GetString(5));
                    Response.Cookies["Depto"].Value = string.Format(reader.GetString(6));

                    Response.Cookies["ID"].Expires = DateTime.Now.AddHours(2);
                    Response.Cookies["Nombre"].Expires = DateTime.Now.AddHours(2);
                    Response.Cookies["Del"].Expires = DateTime.Now.AddHours(2);
                    Response.Cookies["Sub"].Expires = DateTime.Now.AddHours(2);
                    Response.Cookies["Tipo"].Expires = DateTime.Now.AddHours(2);
                    Response.Cookies["Cargo"].Expires = DateTime.Now.AddHours(2);
                    Response.Cookies["Depto"].Expires = DateTime.Now.AddHours(2);
                }
                if (Request.Cookies["ID"].Value != null)
                {
                    if (Request.Cookies["Tipo"].Value == "0")
                    {
                        //Redirecciona a la siguiente pagina ya que el usuario es correcto
                        Response.Redirect("~/Admin/Default.aspx".Replace("#",""));
                    }
                    else
                    {
                        if (Request.Cookies["Tipo"].Value == "1" || Request.Cookies["Tipo"].Value == "2" || Request.Cookies["Tipo"].Value == "3")
                        {
                            //tipo de usuario 1 usuario
                            //Redirecciona a la siguiente pagina ya que el usuario es correcto
                            Response.Redirect("~/Admin/Default.aspx".Replace("#", ""));
                        }
                    }
                }
                else
                {
                    //El usuario y contraseña son incorrectos
                    Response.Write("<script language=javascript>alert('" + "El Usuario y Contraseña No son Correctos" + "');</script>");
                }
            }
            else
            {
                //El usuario y contraseña son incorrectos
                Response.Write("<script language=javascript>alert('" + "El Usuario y Contraseña No son Correctos" + "');</script>");
            }
        }
        catch (Exception ex)
        {
            Response.Write("<script language=javascript>alert('" + ex.Message + "');</script>");
        }     
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string email = "isaac.barrientos@imss.gob.mx";
        ClientScript.RegisterStartupScript(this.GetType(), "mailto", "parent.location='mailto:" + email + "'", true);
    }
}
