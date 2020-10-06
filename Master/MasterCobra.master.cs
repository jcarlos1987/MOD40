﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Master_MasterCobra : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["Nombre"] != null)
        {
            if (Request.Cookies["Tipo"].Value == "2") /*Cobranza*/
            {
                Label1.Text = Request.Cookies["Nombre"].Value;
            }
            else
            {
                Response.Redirect("404.aspx");
            }
        }
        else
        {
            Response.Redirect("~/Default.aspx");
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Cookies["Cargo"].Expires = DateTime.Now.AddHours(-2);
        Response.Cookies["Del"].Expires = DateTime.Now.AddHours(-2);
        Response.Cookies["Depto"].Expires = DateTime.Now.AddHours(-2);
        Response.Cookies["ID"].Expires = DateTime.Now.AddHours(-2);
        Response.Cookies["Nombre"].Expires = DateTime.Now.AddHours(-2);
        Response.Cookies["Sub"].Expires = DateTime.Now.AddHours(-2);
        Response.Cookies["User"].Expires = DateTime.Now.AddHours(-2);
        Response.Cookies["Tipo"].Expires = DateTime.Now.AddHours(-2);
        Response.Redirect("~/Default.aspx");
    }
}
