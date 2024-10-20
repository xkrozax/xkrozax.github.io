<%@ page language="java" import="java.util.*" import="metier.Fonctionnaire" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ListeDossierPermisConstruire2.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%
	Fonctionnaire [] tabFonctionnaire;
	tabFonctionnaire=(Fonctionnaire[])request.getAttribute("listeFonctionnaire"); 
	%>
  </head> 
  <body>    
                <%if(tabFonctionnaire.length>0){ %>
                <%for(int i=0;i<tabFonctionnaire.length;i++) {%>
		        <option value="<%=tabFonctionnaire[i].getIdFonctionnaire()%>">
		        <%=tabFonctionnaire[i].getNom()%> : <%=tabFonctionnaire[i].getFonction()%> 
		        </option>	
		        <%} %>
                <%} %>
  </body>
</html>