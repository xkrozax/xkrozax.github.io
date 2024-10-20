<%@ page language="java" import="java.util.*"    import="metier.Appelsoffres"  contentType="text/html; charset=UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> Gestion des Marchés Publics </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%
	Appelsoffres[] tabAppelsoffres;
	tabAppelsoffres=(Appelsoffres[])request.getAttribute("listeAppelsoffres");
	 %>
	 	     
  </head>
  
  <body>
     <%if(tabAppelsoffres[0] != null){ %>
     <center> <h2> <font color="rgba(0, 120, 220)"> Ce numéro existe dèja </font> </h2> </center>
     <%}else {%> 
     <center> <h2> <font color="rgba(0, 120, 220)"> L'appel d'offre est bien ajoutée </font> </h2> </center>		    
     <%}%>     
        
  </body>
</html>