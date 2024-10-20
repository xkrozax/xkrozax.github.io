<%@ page language="java" import="java.util.*" import="metier.Journauxao" import="metier.Journaux" import="metier.Sousarticle" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%
	Journauxao [] tabJournauxao;
	tabJournauxao=(Journauxao[])request.getAttribute("listeJournauxao"); 
	 %>
	
	
  </head> 
  <body> 
        <option  value="0"></option>
        <%if(tabJournauxao.length>0){ %>
        <%for(int i=0;i<tabJournauxao.length;i++) {%>
		        <option  value="<%=tabJournauxao[i].getIdJournal()%>" >
		        <%=tabJournauxao[i].getNomJournal()%>  
		        </option>	
        <%}} %>
  </body>
</html>