﻿<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="Reporte.aspx.cs" Inherits="Admin_Reporte" %>

<%@ Register assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<html>
    <head>
    <title>MODALIDAD40</title>
    </head>
<body>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" 
        AutoDataBind="true" ToolPanelView="None" 
        onunload="CrystalReportViewer1_Unload" />
    <asp:SqlDataSource ID="CONSUL_NUMERO_PAGOS_NSS" runat="server" ConnectionString="<%$ ConnectionStrings:MOD40_CDSUAConnectionString %>" SelectCommand="
BEGIN
	DECLARE @QUERY NVARCHAR(MAX), @RAZON NVARCHAR(150), @TOT INT, @FEC_SUA DATE 
	TRUNCATE TABLE [MOD40_CDSUA].[dbo].[Rpt_No_Pagos]
	SET @QUERY = 'INSERT INTO [MOD40_CDSUA].[dbo].[Rpt_No_Pagos]([DEL],[SUB],[REGPAT],[PERIODO],[NOMBRE],[RCAS_NUM_AFIL],[DIAS MES],[TOTAL COP],[TOTAL RCV],[RCPS_FECHA_PAGO]
           ,[RCPS_NUM_FOL_SUA],[IMP_TOT],[umf],[movt],[fecha_movt],[salario_BC],[iden_trabaj],[fecha_afil])
SELECT dbo.CDSUPA.RCPS_DEL AS DEL,dbo.CDSUPA.RCPS_SUB AS SUB,dbo.CDSUPA.RCPS_PATRON AS REGPAT ,dbo.CDSUPA.RCPS_PER_PAGO AS PERIODO ,dbo.CDSUAS.RCAS_NOM_TRAB AS NOMBRE, [RCAS_NUM_AFIL],
       dbo.CDSUAS.RCAS_DIAS_COT_MES AS [DIAS MES],(dbo.CDSUAS.RCAS_IMP_EYM_FIJA + dbo.CDSUAS.RCAS_IMP_EYM_EXCE + dbo.CDSUAS.RCAS_IMP_EYM_PRES + dbo.CDSUAS.RCAS_IMP_EYM_ESPE 
       + dbo.CDSUAS.RCAS_IMP_RT + dbo.CDSUAS.RCAS_IMP_IV + dbo.CDSUAS.RCAS_IMP_GUAR + dbo.CDSUAS.RCAS_IMP_ACT_REC_I) AS [TOTAL COP],(dbo.CDSUAS.RCAS_IMP_RET + 
       dbo.CDSUAS.RCAS_IMP_ACT_REC_RET + dbo.CDSUAS.RCAS_IMP_CYV + dbo.CDSUAS.RCAS_IMP_ACT_REC_CYV) AS [TOTAL RCV], dbo.CDSUPA.RCPS_FECHA_PAGO, CONVERT(NVARCHAR(6),dbo.CDSUPA.RCPS_NUM_FOL_SUA) RCPS_NUM_FOL_SUA,
       (dbo.CDSUAS.RCAS_IMP_EYM_FIJA + dbo.CDSUAS.RCAS_IMP_EYM_EXCE + dbo.CDSUAS.RCAS_IMP_EYM_PRES + dbo.CDSUAS.RCAS_IMP_EYM_ESPE + dbo.CDSUAS.RCAS_IMP_RT + 
       dbo.CDSUAS.RCAS_IMP_IV + dbo.CDSUAS.RCAS_IMP_GUAR + dbo.CDSUAS.RCAS_IMP_ACT_REC_I + dbo.CDSUAS.RCAS_IMP_RET + dbo.CDSUAS.RCAS_IMP_ACT_REC_RET + 
       dbo.CDSUAS.RCAS_IMP_CYV + dbo.CDSUAS.RCAS_IMP_ACT_REC_CYV + dbo.CDSUAS.RCAS_IMP_APOR_VOL) AS IMP_TOT, T3.umf, T3.movt, CONVERT(DATE,T3.fecha_movt) AS fecha_movt, 
       T3.salario_BC,T3.iden_trabaj ,(SELECT  TOP 1 CONVERT(DATE,fecha_afil) FROM  '+(SELECT [MOD40].[dbo].[FECHA_MAXIMA] ())+') fecha_afil
  FROM dbo.CDSUAS LEFT JOIN dbo.CDSUPA ON dbo.CDSUAS.RCAS_CVE_UNIT = dbo.CDSUPA.RCPS_CVE_UNIT LEFT JOIN (SELECT nss,[movt] ,CONVERT(DATE,[fecha_movt]) [fecha_movt]
      ,[salario_BC],[umf],CONVERT(DATE,[fecha_afil]) [fecha_afil], iden_trabaj FROM '+(SELECT [MOD40].[dbo].[FECHA_MAXIMA] ())+' WHERE SUBSTRING(reg_pat,10,2)=''40'') T3 
      ON dbo.CDSUAS.RCAS_NUM_AFIL=REPLACE(T3.nss,''-'','''')
     WHERE dbo.CDSUAS.RCAS_NUM_AFIL = '''+ @NSS +''''
EXEC (@QUERY)        
     
	SET @RAZON = (SELECT TOP 1 [Raz_Soc] FROM [MOD40_CDSUA].[dbo].[PATRONES] WHERE [Reg_Pat] = (SELECT TOP 1 [RCPS_PATRON] 
			FROM [MOD40_CDSUA].[dbo].[CDSUPA] T1 INNER JOIN [MOD40_CDSUA].[dbo].[CDSUAS] T2 ON T1.RCPS_CVE_UNIT=T2.RCAS_CVE_UNIT  WHERE T2.RCAS_NUM_AFIL = @NSS))
        SET @TOT = (SELECT COUNT(*) FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos])			
        SET @FEC_SUA = (SELECT [MOD40_CDSUA].[dbo].[FECHA_SUA] ())

        SELECT [DEL],[SUB],[REGPAT],[PERIODO],[NOMBRE],[RCAS_NUM_AFIL],@RAZON RAZON,
			[DIAS MES],[TOTAL COP],[TOTAL RCV],[RCPS_FECHA_PAGO],[RCPS_NUM_FOL_SUA],[IMP_TOT],[umf],[movt],[fecha_movt],[salario_BC],[iden_trabaj],[fecha_afil],
			@TOT TOT_PAGOS, @FEC_SUA SUA
	  FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos] ORDER BY [RCPS_FECHA_PAGO] DESC
END">
        <SelectParameters>
            <asp:SessionParameter Name="NSS" SessionField="nss_pagos" />           
        </SelectParameters>
    </asp:SqlDataSource>
    

    <asp:SqlDataSource ID="CONSULTA_PAGOS_X_PERIODO" runat="server" ConnectionString="<%$ ConnectionStrings:MOD40_CDSUAConnectionString %>" SelectCommand="
       BEGIN
DECLARE @QUERY NVARCHAR(MAX) ,@NOM_TRAB NVARCHAR(150),@razsocial nvarchar(150), @reg nvarchar(25),@FEC_SUA DATE, @PAGOS INT
   TRUNCATE TABLE [Rpt_No_Pagos_PERI]
SET @QUERY = 'INSERT INTO [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_PERI]([PERIO],[TOT_PAGOS] ,[RCPS_DEL] ,[RCPS_SUB],[IMP_TOT],[DIAS_COT],[RCPS_PATRON],[RCAS_NUM_AFIL],[fecha_movt],[iden_trabaj],
            [movt],[salario_BC],[umf],[fecha_afil])
SELECT ([RCPS_PER_PAGO]) PERIO,COUNT (*) AS TOT_PAGOS, dbo.CDSUPA.RCPS_DEL,dbo.CDSUPA.RCPS_SUB
            ,SUM((dbo.CDSUAS.RCAS_IMP_EYM_FIJA + dbo.CDSUAS.RCAS_IMP_EYM_EXCE + dbo.CDSUAS.RCAS_IMP_EYM_PRES 
            + dbo.CDSUAS.RCAS_IMP_EYM_ESPE + dbo.CDSUAS.RCAS_IMP_RT + dbo.CDSUAS.RCAS_IMP_IV 
            + dbo.CDSUAS.RCAS_IMP_GUAR + dbo.CDSUAS.RCAS_IMP_ACT_REC_I + dbo.CDSUAS.RCAS_IMP_RET 
            + dbo.CDSUAS.RCAS_IMP_ACT_REC_RET + dbo.CDSUAS.RCAS_IMP_CYV + dbo.CDSUAS.RCAS_IMP_ACT_REC_CYV 
            + dbo.CDSUAS.RCAS_IMP_APOR_VOL)) AS IMP_TOT, SUM(dbo.CDSUAS.RCAS_DIAS_COT_MES) AS DIAS_COT,RCPS_PATRON,[RCAS_NUM_AFIL]
            ,T3.fecha_movt, T3.iden_trabaj,T3.movt,T3.salario_BC,T3.umf
            ,(SELECT  TOP 1 CONVERT(DATE,fecha_afil) FROM '+(SELECT [MOD40].[dbo].[FECHA_MAXIMA] ())+') fecha_afil  
       FROM dbo.CDSUAS LEFT JOIN  dbo.CDSUPA 
         ON dbo.CDSUAS.RCAS_CVE_UNIT = dbo.CDSUPA.RCPS_CVE_UNIT LEFT JOIN (SELECT nss,[movt] ,CONVERT(DATE,[fecha_movt]) [fecha_movt]
      ,[salario_BC],[umf],CONVERT(DATE,[fecha_afil]) [fecha_afil], iden_trabaj FROM '+(SELECT [MOD40].[dbo].[FECHA_MAXIMA] ())+' WHERE SUBSTRING(reg_pat,10,2)=''40'') T3
      ON dbo.CDSUAS.RCAS_NUM_AFIL=REPLACE(T3.nss,''-'','''')
      WHERE dbo.CDSUAS.RCAS_NUM_AFIL = '''+@NSS +'''
      GROUP BY [RCPS_PER_PAGO],dbo.CDSUPA.RCPS_DEL,dbo.CDSUPA.RCPS_SUB,RCPS_PATRON,[RCAS_NUM_AFIL],T3.fecha_movt, T3.iden_trabaj,T3.movt,T3.nss,T3.salario_BC,T3.umf
      ORDER BY PERIO DESC'
EXEC (@QUERY)      
  SET @NOM_TRAB = (SELECT TOP 1 [RCAS_NOM_TRAB] FROM dbo.CDSUAS LEFT OUTER JOIN  dbo.CDSUPA ON dbo.CDSUAS.RCAS_CVE_UNIT = dbo.CDSUPA.RCPS_CVE_UNIT WHERE dbo.CDSUAS.RCAS_NUM_AFIL = @NSS)         
  SET @reg=(SELECT TOP 1 [RCPS_PATRON] FROM [MOD40_CDSUA].[dbo].[CDSUPA] T1 LEFT OUTER JOIN [MOD40_CDSUA].[dbo].[CDSUAS] T2 ON T1.RCPS_CVE_UNIT=T2.RCAS_CVE_UNIT WHERE T2.RCAS_NUM_AFIL = @NSS)
  SET @razsocial=(SELECT TOP 1 [Raz_Soc] FROM [MOD40_CDSUA].[dbo].[PATRONES] WHERE [Reg_Pat] = @reg)
  SET @FEC_SUA = (SELECT [MOD40_CDSUA].[dbo].[FECHA_SUA] ())
  SET @PAGOS = (SELECT SUM([TOT_PAGOS]) PAGOS FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_PERI])
 SELECT [PERIO],[TOT_PAGOS],[RCPS_DEL],[RCPS_SUB],[IMP_TOT],[DIAS_COT],[RCPS_PATRON],@razsocial RAZON_SOCIAL,[RCAS_NUM_AFIL],@NOM_TRAB NOMBRE,[fecha_movt],[iden_trabaj],[movt],[salario_BC],[umf],[fecha_afil],@FEC_SUA SUA,@PAGOS PAGOSt
  FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_PERI]                                           
END  ">
        <SelectParameters>
            <asp:SessionParameter Name="NSS" SessionField="nss_pagos" />
        </SelectParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="CONSULTA_PAGOS_X_ANIO" runat="server" ConnectionString="<%$ ConnectionStrings:MOD40_CDSUAConnectionString %>" SelectCommand="
        BEGIN
   DECLARE @NOM_TRAB NVARCHAR(150),@razsocial nvarchar(150), @reg nvarchar(20), @QUERY NVARCHAR(MAX) ,@FEC_SUA DATE, @PAGOS INT
 TRUNCATE TABLE [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_ANIO]
 SET @QUERY = 'INSERT INTO [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_ANIO]([ANIO],[TOT_PAGOS],[RCPS_DEL],[RCPS_SUB],[IMP_TOT],[DIAS_COT],[RCPS_PATRON],[RCAS_NUM_AFIL],[movt],[fecha_movt],[salario_BC],[iden_trabaj],[umf],[fecha_afil]) 
 SELECT ANIO,TOT_PAGOS,RCPS_DEL,RCPS_SUB,IMP_TOT,DIAS_COT,RCPS_PATRON,RCAS_NUM_AFIL,movt,fecha_movt,salario_BC,iden_trabaj,umf,(SELECT  TOP 1 CONVERT(DATE,fecha_afil) FROM  '+(SELECT [MOD40].[dbo].[FECHA_MAXIMA] ())+') fecha_afil FROM (SELECT YEAR(dbo.CDSUPA.RCPS_FECHA_PAGO) AS ANIO,COUNT (*) AS TOT_PAGOS, dbo.CDSUPA.RCPS_DEL,dbo.CDSUPA.RCPS_SUB ,
       SUM((dbo.CDSUAS.RCAS_IMP_EYM_FIJA + dbo.CDSUAS.RCAS_IMP_EYM_EXCE + dbo.CDSUAS.RCAS_IMP_EYM_PRES + dbo.CDSUAS.RCAS_IMP_EYM_ESPE + dbo.CDSUAS.RCAS_IMP_RT + dbo.CDSUAS.RCAS_IMP_IV + dbo.CDSUAS.RCAS_IMP_GUAR + dbo.CDSUAS.RCAS_IMP_ACT_REC_I + dbo.CDSUAS.RCAS_IMP_RET +
       dbo.CDSUAS.RCAS_IMP_ACT_REC_RET + dbo.CDSUAS.RCAS_IMP_CYV + dbo.CDSUAS.RCAS_IMP_ACT_REC_CYV + dbo.CDSUAS.RCAS_IMP_APOR_VOL)) AS IMP_TOT, SUM(dbo.CDSUAS.RCAS_DIAS_COT_MES) AS DIAS_COT,RCPS_PATRON,[RCAS_NUM_AFIL]
  FROM dbo.CDSUAS LEFT JOIN  dbo.CDSUPA ON dbo.CDSUAS.RCAS_CVE_UNIT = dbo.CDSUPA.RCPS_CVE_UNIT WHERE dbo.CDSUAS.RCAS_NUM_AFIL = '''+ @NSS +''' GROUP BY YEAR(dbo.CDSUPA.RCPS_FECHA_PAGO),dbo.CDSUPA.RCPS_DEL,dbo.CDSUPA.RCPS_SUB,RCPS_PATRON,[RCAS_NUM_AFIL]) T1
 LEFT JOIN (SELECT [nss],[movt] ,[fecha_movt],[salario_BC],[iden_trabaj],[umf],[fecha_afil] FROM '+(SELECT [MOD40].[dbo].[FECHA_MAXIMA] ())+' WHERE SUBSTRING(reg_pat,10,2)=''40'') T2
 ON T1.RCAS_NUM_AFIL=REPLACE(T2.[nss],''-'','''') ORDER BY ANIO DESC'
EXEC(@QUERY) 
SET @NOM_TRAB = (SELECT TOP 1 [RCAS_NOM_TRAB] FROM dbo.CDSUAS LEFT OUTER JOIN  dbo.CDSUPA ON dbo.CDSUAS.RCAS_CVE_UNIT = dbo.CDSUPA.RCPS_CVE_UNIT
                  WHERE dbo.CDSUAS.RCAS_NUM_AFIL = @NSS)   
SET @reg=(SELECT TOP 1 [RCPS_PATRON] FROM [MOD40_CDSUA].[dbo].[CDSUPA] T1 LEFT OUTER JOIN [MOD40_CDSUA].[dbo].[CDSUAS] T2 ON T1.RCPS_CVE_UNIT=T2.RCAS_CVE_UNIT
           WHERE T2.RCAS_NUM_AFIL = @NSS)
        SET @razsocial=(SELECT TOP 1 [Raz_Soc] FROM [MOD40_CDSUA].[dbo].[PATRONES] WHERE [Reg_Pat] = @reg)
        SET @FEC_SUA = (SELECT [MOD40_CDSUA].[dbo].[FECHA_SUA] ())     
        SET @PAGOS =(SELECT SUM([TOT_PAGOS]) FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_ANIO])    
 SELECT [ANIO],[TOT_PAGOS],[RCPS_DEL],[RCPS_SUB],[IMP_TOT],[DIAS_COT],[RCPS_PATRON],[RCAS_NUM_AFIL] ,@NOM_TRAB Nombre,@reg RegistroP, [movt],[fecha_movt] ,[salario_BC],[iden_trabaj],[umf],[fecha_afil],@FEC_SUA SUA, @PAGOS PAGOS, @razsocial RazonSocial
   FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_ANIO]  
END ">
        <SelectParameters>
            <asp:SessionParameter Name="NSS" SessionField="nss_pagos" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="RTP_PAGOS_RETRASADOS" runat="server" ConnectionString="<%$ ConnectionStrings:MOD40_CDSUAConnectionString %>" SelectCommand="BEGIN
	DECLARE @QUERY NVARCHAR(MAX),@FEC_SUA DATE
IF @PERIODO >= -12
	BEGIN
		SET @QUERY ='/*EXTRACCION DE LOS REGISTROS DE ACUERDO AL NUMERO DE MESES ESPECIFICADO POR EL USUARIO*/
		TRUNCATE TABLE [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_UNO]
		INSERT INTO [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_UNO]([RCAS_NUM_AFIL] ,[RCPS_DEL],[RCPS_SUB],[RCPS_PATRON],[RCAS_NOM_TRAB],[RCPS_FECHA_PAGO])
		SELECT dbo.CDSUAS.RCAS_NUM_AFIL ,dbo.CDSUPA.RCPS_DEL ,dbo.CDSUPA.RCPS_SUB ,dbo.CDSUPA.RCPS_PATRON ,dbo.CDSUAS.RCAS_NOM_TRAB ,dbo.CDSUPA.RCPS_FECHA_PAGO 
		  FROM dbo.CDSUPA LEFT JOIN dbo.CDSUAS ON dbo.CDSUAS.RCAS_CVE_UNIT = dbo.CDSUPA.RCPS_CVE_UNIT WHERE dbo.CDSUPA.RCPS_FECHA_PAGO BETWEEN 
			   (SELECT DATEADD(m, DATEDIFF(m,0,DATEADD(MONTH,('+ CONVERT(NVARCHAR(10),@PERIODO)+' + 1),MAX(DATEADD(MONTH,-1,[RCPS_FECHA_PAGO])))), 0) FechaMinima  FROM [MOD40_CDSUA].[dbo].[CDSUPA]) AND
			   (SELECT  DATEADD(ms,-3,DATEADD(mm,0,DATEADD(mm,DATEDIFF(mm,0,DATEADD(MONTH,0,MAX([RCPS_FECHA_PAGO])))+1,0))) FechaMaxima  FROM [MOD40_CDSUA].[dbo].[CDSUPA])
		/*EXTRACCION DE REGISTROS DE ACUERDO AL NUMERO DE MESES MENOS 1 MES */
		TRUNCATE TABLE [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_DOS] 
		INSERT INTO [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_DOS]([RCAS_NUM_AFIL],[RCPS_DEL],[RCPS_SUB],[RCPS_PATRON],[RCAS_NOM_TRAB],[RCPS_FECHA_PAGO])         
		SELECT dbo.CDSUAS.RCAS_NUM_AFIL ,dbo.CDSUPA.RCPS_DEL ,dbo.CDSUPA.RCPS_SUB ,dbo.CDSUPA.RCPS_PATRON ,dbo.CDSUAS.RCAS_NOM_TRAB ,dbo.CDSUPA.RCPS_FECHA_PAGO 
		  FROM dbo.CDSUPA LEFT JOIN dbo.CDSUAS ON dbo.CDSUAS.RCAS_CVE_UNIT = dbo.CDSUPA.RCPS_CVE_UNIT WHERE dbo.CDSUPA.RCPS_FECHA_PAGO BETWEEN 
       (SELECT DATEADD(m, DATEDIFF(m,0,DATEADD(MONTH, '+ CONVERT(NVARCHAR(10),@PERIODO)+' ,MAX(DATEADD(MONTH,-1,[RCPS_FECHA_PAGO])))), 0) FechaMinima  FROM [MOD40_CDSUA].[dbo].[CDSUPA]) AND
       (SELECT  DATEADD(ms,-3,DATEADD(mm,0,DATEADD(mm,DATEDIFF(mm,0,DATEADD(MONTH,0,MAX([RCPS_FECHA_PAGO])))+1,0))) FechaMaxima  FROM [MOD40_CDSUA].[dbo].[CDSUPA])
       DELETE TB2 FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_UNO] TB1 INNER JOIN [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_DOS] TB2 ON TB1.[RCAS_NUM_AFIL]=TB2.[RCAS_NUM_AFIL]
       /*EXTRACCION DEL ULTIMO PAGO DE LOS REGISTROS*/
		TRUNCATE TABLE [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_PAGOS]
		INSERT INTO [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_PAGOS]([nss],[fecha_movt],[salario_BC],[RCAS_NUM_AFIL],[RCPS_DEL],[RCPS_SUB],[RCPS_PATRON],[RCAS_NOM_TRAB],[FECHA_PAGO],[meses],[fecha_afil])
		SELECT nss,fecha_movt,salario_BC,RCAS_NUM_AFIL,RCPS_DEL,RCPS_SUB,RCPS_PATRON,RCAS_NOM_TRAB,MAX(RCPS_FECHA_PAGO) FECHA_PAGO, '+ CONVERT(NVARCHAR(10),@PERIODO*-1)+' meses, [fecha_afil]  FROM 
		(SELECT [nss],[fecha_movt] ,[salario_BC],[fecha_afil] FROM '+ (SELECT [MOD40].[dbo].[FECHA_MAXIMA] ()) + ' WHERE SUBSTRING(reg_pat, 10,2)=''40'') TB1 LEFT JOIN
		(SELECT [RCAS_NUM_AFIL],[RCPS_DEL],[RCPS_SUB],[RCPS_PATRON],[RCAS_NOM_TRAB],[RCPS_FECHA_PAGO] FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_DOS]) TB2
		ON REPLACE(TB1.nss,''-'','''')=TB2.[RCAS_NUM_AFIL] WHERE NOT [RCPS_FECHA_PAGO] IS NULL
		GROUP BY nss,fecha_movt,salario_BC,RCAS_NUM_AFIL,RCPS_DEL,RCPS_SUB,RCPS_PATRON,RCAS_NOM_TRAB, [fecha_afil]'
		PRINT @QUERY
		EXEC (@QUERY)
	END
ELSE 
	BEGIN
		TRUNCATE TABLE [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_PAGOS]
		SET @PERIODO = -1
		WHILE @PERIODO >= -50
			BEGIN		
			   SET @QUERY ='/*EXTRACCION DE LOS REGISTROS DE ACUERDO AL NUMERO DE MESES ESPECIFICADO POR EL USUARIO*/
		TRUNCATE TABLE [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_UNO]
		INSERT INTO [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_UNO]([RCAS_NUM_AFIL] ,[RCPS_DEL],[RCPS_SUB],[RCPS_PATRON],[RCAS_NOM_TRAB],[RCPS_FECHA_PAGO])
		SELECT dbo.CDSUAS.RCAS_NUM_AFIL ,dbo.CDSUPA.RCPS_DEL ,dbo.CDSUPA.RCPS_SUB ,dbo.CDSUPA.RCPS_PATRON ,dbo.CDSUAS.RCAS_NOM_TRAB ,dbo.CDSUPA.RCPS_FECHA_PAGO 
		  FROM dbo.CDSUPA LEFT JOIN dbo.CDSUAS ON dbo.CDSUAS.RCAS_CVE_UNIT = dbo.CDSUPA.RCPS_CVE_UNIT WHERE dbo.CDSUPA.RCPS_FECHA_PAGO BETWEEN 
			   (SELECT DATEADD(m, DATEDIFF(m,0,DATEADD(MONTH,('+ CONVERT(NVARCHAR(10),@PERIODO)+' + 1),MAX([RCPS_FECHA_PAGO]))), 0) FechaMinima  FROM [MOD40_CDSUA].[dbo].[CDSUPA]) AND
			   (SELECT  DATEADD(ms,-3,DATEADD(mm,0,DATEADD(mm,DATEDIFF(mm,0,DATEADD(MONTH,0,MAX([RCPS_FECHA_PAGO])))+1,0))) FechaMaxima  FROM [MOD40_CDSUA].[dbo].[CDSUPA])
		/*EXTRACCION DE REGISTROS DE ACUERDO AL NUMERO DE MESES MENOS 1 MES */
		TRUNCATE TABLE [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_DOS]   
		INSERT INTO [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_DOS]([RCAS_NUM_AFIL],[RCPS_DEL],[RCPS_SUB],[RCPS_PATRON],[RCAS_NOM_TRAB],[RCPS_FECHA_PAGO])                
		SELECT dbo.CDSUAS.RCAS_NUM_AFIL ,dbo.CDSUPA.RCPS_DEL ,dbo.CDSUPA.RCPS_SUB ,dbo.CDSUPA.RCPS_PATRON ,dbo.CDSUAS.RCAS_NOM_TRAB ,dbo.CDSUPA.RCPS_FECHA_PAGO 
		  FROM dbo.CDSUPA LEFT JOIN dbo.CDSUAS ON dbo.CDSUAS.RCAS_CVE_UNIT = dbo.CDSUPA.RCPS_CVE_UNIT WHERE dbo.CDSUPA.RCPS_FECHA_PAGO BETWEEN 
       (SELECT DATEADD(m, DATEDIFF(m,0,DATEADD(MONTH, '+ CONVERT(NVARCHAR(10),@PERIODO)+' ,MAX([RCPS_FECHA_PAGO]))), 0) FechaMinima  FROM [MOD40_CDSUA].[dbo].[CDSUPA]) AND
       (SELECT  DATEADD(ms,-3,DATEADD(mm,0,DATEADD(mm,DATEDIFF(mm,0,DATEADD(MONTH,0,MAX([RCPS_FECHA_PAGO])))+1,0))) FechaMaxima  FROM [MOD40_CDSUA].[dbo].[CDSUPA])
       DELETE TB2 FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_UNO] TB1 INNER JOIN [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_DOS] TB2 ON TB1.[RCAS_NUM_AFIL]=TB2.[RCAS_NUM_AFIL]
       /*EXTRACCION DEL ULTIMO PAGO DE LOS REGISTROS*/
		INSERT INTO [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_PAGOS]([nss],[fecha_movt],[salario_BC],[RCAS_NUM_AFIL],[RCPS_DEL],[RCPS_SUB],[RCPS_PATRON],[RCAS_NOM_TRAB],[FECHA_PAGO],[meses],[fecha_afil])
		SELECT nss,fecha_movt,salario_BC,RCAS_NUM_AFIL,RCPS_DEL,RCPS_SUB,RCPS_PATRON,RCAS_NOM_TRAB,MAX(RCPS_FECHA_PAGO) FECHA_PAGO, '+ CONVERT(NVARCHAR(10),@PERIODO*-1)+' meses,[fecha_afil]  FROM 
		(SELECT [nss],[fecha_movt] ,[salario_BC],[fecha_afil] FROM '+ (SELECT [MOD40].[dbo].[FECHA_MAXIMA] ()) + ' WHERE SUBSTRING(reg_pat, 10,2)=''40'') TB1 LEFT JOIN
		(SELECT [RCAS_NUM_AFIL],[RCPS_DEL],[RCPS_SUB],[RCPS_PATRON],[RCAS_NOM_TRAB],[RCPS_FECHA_PAGO] FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_DOS]) TB2
		ON REPLACE(TB1.nss,''-'','''')=TB2.[RCAS_NUM_AFIL] WHERE NOT [RCPS_FECHA_PAGO] IS NULL
		GROUP BY nss,fecha_movt,salario_BC,RCAS_NUM_AFIL,RCPS_DEL,RCPS_SUB,RCPS_PATRON,RCAS_NOM_TRAB,[fecha_afil]'		
		PRINT @QUERY
			   SET @PERIODO = @PERIODO - 1 
			   EXEC (@QUERY)
			END		
	END
	SET @FEC_SUA = (SELECT [MOD40_CDSUA].[dbo].[FECHA_SUA] ())
	IF @SUB = 01 OR @SUB = 05
       BEGIN
			SELECT [nss],CONVERT(DATE,[fecha_movt]) [fecha_movt],[salario_BC],[RCAS_NUM_AFIL],[RCPS_DEL],[RCPS_SUB],[RCPS_PATRON],[RCAS_NOM_TRAB],[FECHA_PAGO]
		    ,[meses],(SELECT COUNT(*) FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_PAGOS] WHERE [RCPS_SUB]=@SUB) TOT_PAGOS,[fecha_afil],@FEC_SUA SUA
			FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_PAGOS] WHERE [RCPS_SUB]=@SUB
       END
    ELSE
		BEGIN
			SELECT [nss],CONVERT(DATE,[fecha_movt]) [fecha_movt],[salario_BC],[RCAS_NUM_AFIL],[RCPS_DEL],[RCPS_SUB],[RCPS_PATRON],[RCAS_NOM_TRAB],[FECHA_PAGO],[meses]
			   ,(SELECT COUNT(*) FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_PAGOS]) TOT_PAGOS,[fecha_afil],@FEC_SUA SUA
		    FROM [MOD40_CDSUA].[dbo].[Rpt_No_Pagos_RETRASO_PAGOS]
		END
END">
        <SelectParameters>
            <asp:SessionParameter Name="SUB" SessionField="Procedimiento" />
            <asp:SessionParameter Name="PERIODO" DbType="Double" SessionField="anio" />
        </SelectParameters>
    </asp:SqlDataSource>

</body>       
</html>

