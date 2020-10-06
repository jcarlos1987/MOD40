using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Configuration;

public partial class Admin_cambiar : System.Web.UI.Page
{
    string strConnString = ConfigurationManager.ConnectionStrings["MOD40ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (PassAnterior.Text != "")
        {
            if (PassNueva.Text != "")
            {
                if (ConfirPass.Text != "")
                {
                    if (PassNueva.Text.Equals(ConfirPass.Text))
                    {
                        SqlConnection conn1 = new SqlConnection(strConnString);
                        try
                        {
                            conn1.Open();
                            string sql = null;
                            sql = "UPDATE [Panel_Control].[dbo].[Usuarios] SET [pass] = @PASSWORD WHERE [id] = @USER AND [pass] = @PASS";
                            SqlCommand cmd = new SqlCommand(sql, conn1);

                            cmd.Parameters.Add("@PASSWORD", SqlDbType.NVarChar, 50);
                            cmd.Parameters["@PASSWORD"].Value = PassNueva.Text;

                            cmd.Parameters.Add("@USER", SqlDbType.NVarChar, 50);
                            cmd.Parameters["@USER"].Value = Request.Cookies["ID"].Value;

                            cmd.Parameters.Add("@PASS", SqlDbType.NVarChar, 50);
                            cmd.Parameters["@PASS"].Value = PassAnterior.Text;

                            cmd.Connection = conn1;
                            int rs = cmd.ExecuteNonQuery();
                            cmd.Connection.Close();
                            if (rs == 1)
                            {
                                Response.Cookies["ID"].Expires = DateTime.Now.AddYears(-2);
                                Response.Cookies["Nombre"].Expires = DateTime.Now.AddYears(-2);
                                Response.Cookies["Del"].Expires = DateTime.Now.AddYears(-2);
                                Response.Cookies["Sub"].Expires = DateTime.Now.AddYears(-2);
                                Response.Cookies["Tipo"].Expires = DateTime.Now.AddYears(-2);
                                Response.Cookies["Cargo"].Expires = DateTime.Now.AddYears(-2);
                                Response.Cookies["Depto"].Expires = DateTime.Now.AddYears(-2);
                                Response.Redirect("cambiar.aspx");
                            }
                        }
                        catch (Exception Excep)
                        {
                            this.ClientScript.RegisterStartupScript(this.GetType(), "Error1", "alertify.error('"+Excep.Message+"');", true);
                        }
                    }
                    else
                    {
                        this.ClientScript.RegisterStartupScript(this.GetType(), "Error2", "alertify.error('No coinciden las contraseñas');", true);
                    }
                }
                else
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "Error3", "alertify.error('Confirmar Contraseña. ');", true);
                }
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "Error4", "alertify.error('Ingresa Contraseña Nueva.');", true);
            }
        }
        else
        {
            this.ClientScript.RegisterStartupScript(this.GetType(), "Error5", "alertify.error('Ingresa contraseña Anterior.');", true);
        }
        
    }

    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {
        SqlConnection conn1 = new SqlConnection(strConnString);
        try
        {
            SqlCommand command = new SqlCommand("SELECT T1.[id], T2.[nombre], T1.[del], T1.[sub], [user_type], [cargo],[depto] FROM [MOD40].[dbo].[User] T1 INNER JOIN [Panel_Control].[dbo].[Usuarios] T2 ON T1.[id]=T2.[id] WHERE T2.[user]='" + Request.Cookies["ID"].Value + "' AND T2.[pass]='" + PassAnterior.Text + "' AND T1.[id]=T2.[id]", conn1);
            conn1.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                PassAnterior.Attributes.Add("value", PassAnterior.Text);
                PassNueva.Focus();
            }
            else
            {
                PassAnterior.Attributes.Add("value", PassAnterior.Text);
                this.ClientScript.RegisterStartupScript(this.GetType(), "Error6", "alertify.error('La Contraseña Anterior no corresponde. Intenta de nuevo');", true);
                PassAnterior.Focus();               
            }
        }
        catch (Exception Msj)
        {
            this.ClientScript.RegisterStartupScript(this.GetType(), "Error7", "alertify.error('" + Msj.Message + "');", true);
        }
    }
}