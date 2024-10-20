<%@ page language="java" import="java.util.*" import="metier.Programmeprevisionnel" contentType="text/html; charset=UTF-8"%>
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
	Programmeprevisionnel[] tabProgramme;
	tabProgramme=(Programmeprevisionnel[])request.getAttribute("listeProgramme");
	 %>
  </head> 
  <body>  
     <%if(tabProgramme.length>0){ %>
     <option  value="0"> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- </option>     
     <% for(int i=0;i<tabProgramme.length;i++) {%>
     <option  value="<%= tabProgramme[i].getIdProgramme() %>"><%= tabProgramme[i].getObjetProgramme() %></option> 
     <% }
     } else{ }%>
     
  </body>
</html>