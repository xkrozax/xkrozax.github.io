<%@ page language="java" import="java.util.*" import="java.text.SimpleDateFormat" import="metier.Appelsoffres" contentType="text/html; charset=UTF-8"%>
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
	Appelsoffres[] tabAppelsoffres;
	tabAppelsoffres=(Appelsoffres[])request.getAttribute("listeAppelsoffres");
	SimpleDateFormat inSDF = new SimpleDateFormat("yyyy-mm-dd");
	SimpleDateFormat outSDF = new SimpleDateFormat("dd-mm-yyyy");
	String DateDossier1 ="";
	String DateDossier2 ="";
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    }
	 %>
	<% int size = tabAppelsoffres.length;  
			int sizeParPage = 16;
			int nbPage = 0;
			int marge = size%sizeParPage;
			if ( size <= sizeParPage ){
			nbPage = 1;
			}
			else 
			 {
			   if (marge==0){
			   nbPage = size/sizeParPage;
			   }
			   else{
			   nbPage = size/sizeParPage+1;
			   }
			 } 		 
			int numPage = 0;		
	%>		
	
	<%for(int i=0;i<tabAppelsoffres.length;i++) {%>
    <script type="text/javascript">
   	$('#ajouterEnregistrementMarches<%=i%>').click(function ajouterEnregistrementMarches() 
    {         
        $("#chargement").show();
        $("#idAppelOffre").val("<%= tabAppelsoffres[i].getIdAppelOffre() %>");
        $("#numEnregistrement").val($('#numEnregistrement2<%=i%>').val());
        $("#dateEnregistrement").val($('#dateEnregistrement2<%=i%>').val());
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterEnregistrementMarches.do", 
            data:$("#formRechercherMarches").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide(); 
               afficherBienEnregistrer();                     
            } 
         }); 
    } 
    );  
    </script>
    <%} %>   
  </head> 
  <body>  
     <%if(tabAppelsoffres.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Résultat </center>
      <%} %>
     <%if(tabAppelsoffres.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="4" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >     <tr>    
     <tr> 
     <th width="82"> N°Marché</th>
     <th width="156"> N° d'enregistrement </th>
     <th> Date d'enregistrement </th>
     <% if( (role.equals("Représentant Chef Service Marchés") || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>              
     <th>  </th>
     <%} %>
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr>  
     <td align="center"><%= tabAppelsoffres[i].getNumMarches() %> / <%= tabAppelsoffres[i].getAnneeMarches() %> </td>      
     <td align="center"> <input type="text" name="numEnregistrement2<%=i%>" id="numEnregistrement2<%=i%>"   value="<%=tabAppelsoffres[i].getNumEnregistrement()%>" size="14"/> </td>        
     <td align="center"> <input type="date" name="dateEnregistrement2<%=i%>" id="dateEnregistrement2<%=i%>"   value="<%=tabAppelsoffres[i].getDateEnregistrement()%>" size="4"/>          
     <% if( (role.equals("Représentant Chef Service Marchés") || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>                 
     <td align="center"><input type="button" class="btn btn-default4" id="ajouterEnregistrementMarches<%=i%>"  value="Valider" size="35"/> </td>    
     <%} %>
     </tr>
     <%} %>
     </table>
     <%} %>
     <%} %>
    
  </body>
</html>