<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="Ver.aspx.cs" Inherits="Admin_Ver" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<html>
    <head>
    <title>MODALIDAD40</title>
    </head>
<body>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" 
        AutoDataBind="true" onunload="CrystalReportViewer1_Unload" />
</body>       
</html>

