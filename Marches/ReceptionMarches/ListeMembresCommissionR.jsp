<%@ page language="java" import="java.util.*" import="metier.Membrecommissionreception"  import="metier.Fonctionnaire"  contentType="text/html; charset=UTF-8"%>
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
	Membrecommissionreception[] tabMembrecommssion;
	tabMembrecommssion=(Membrecommissionreception[])request.getAttribute("listeMembresCommssion");
	 %>
	 <%
	Fonctionnaire [] tabFonctionnaire;
	tabFonctionnaire=(Fonctionnaire[])request.getAttribute("listeFonctionnaire"); 
	%>
	<% int size = tabMembrecommssion.length;  
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
	 
	
	<script type="text/javascript">
    $('#ajouterMembreCommission').click(function ajouterMembreCommission() 
    { 
        $("#chargement").show(); 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterMembreCommission3.do", 
            data:$("#formAjouterCommission").serialize(),
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
               $("#listeMembresCommission").html(html);      
            } 
         }); 
    } 
    );
    </script>
    
	<%for(int i=0;i<tabMembrecommssion.length;i++) {%>
    <script type="text/javascript">
    $('#modifierMembreCommission<%=i%>').click(function modifierMembreCommission() 
    { 
        $("#chargement").show();
        $("#idMembreCommission").val("<%= tabMembrecommssion[i].getIdMembreCommssion() %>");
        $("#idFonctionnaire").val($('#idFonctionnaire2<%=i%>').val());
        $("#role").val($('#role2<%=i%>').val()); 
       
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierMembreCommission3.do", 
            data:$("#formAjouterCommission").serialize(),
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
            } 
         }); 
    } 
    );
   	$('#supprimerMembreCommssion<%=i%>').click(function supprimerMembreCommssion() 
    {         
        $("#idMembreCommission").val("<%= tabMembrecommssion[i].getIdMembreCommssion() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligneM<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialog5").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialog5").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerMembreCommission3.do", 
                               data:$("#formAjouterCommission").serialize(),
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
                              $('#ligneM<%=i%>').hide(); 
                              $("#dialog4").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialog4").dialog("close");                   
                              },
                              },
               width: 422,
               height: 192,          
               position: {
			       my: "center",
			       at: "center",
			       of: window,
			       collision: "fit",
			       // Ensure the titlebar is always visible
			       using: function( pos ) {
			     	   var topOffset = $( this ).css( pos ).offset().top;
				       if ( topOffset < 0 ) {
					   $( this ).css( "top", pos.top - topOffset );
				       }
			      }
		       }             
               });
               $( "#dialog4" ).dialog("open");                                 
            } 
         }); 
               // ---------------------------                                     
                 $("#dialog5").dialog("close"); 
                  },
               },
               width: 422,
               height: 192,          
               position: {
			       my: "center",
			       at: "center",
			       of: window,
			       collision: "fit",
			       // Ensure the titlebar is always visible
			       using: function( pos ) {
			     	   var topOffset = $( this ).css( pos ).offset().top;
				       if ( topOffset < 0 ) {
					   $( this ).css( "top", pos.top - topOffset );
				       }
			      }
		       }             
               });
               $( "#dialog5" ).dialog("open");          
    } 
    );  
    </script>  
    <%} %>   
  </head> 
  <body>  
     <%if(tabMembrecommssion.length>0){ %>
     <%}
       else
       { %>
     <table   border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="800" >    
     <tr>    
     
     <th> Nom du Membre </th>   
     <th colspan="2"> <input type="button" class="btn btn-default4" id="ajouterMembreCommission"  value=" Ajouter membre de l'équipe du projet " size="35"/> </th>        
     </tr> 
     <tr><td colspan="11"> <center>Aucun Membre</center> </td></tr>  
     </table>
      <%} %>
     <%if(tabMembrecommssion.length>0){ %>
     <table   border="3" bgcolor=""   bordercolor="#000000" class="table table-hover "  width="800" >    
     <tr>    
     <th> Nom du Membre </th>   
     <th colspan="2"> <input type="button" class="btn btn-default4" id="ajouterMembreCommission"  value=" Ajouter membre de l'équipe du projet " size="35"/> </th>        
     </tr>   
     <%for(int i=0;i < size;i++) {%>
     <input type="hidden" name="idFonctionnaire2<%=i%>"   id="idFonctionnaire2<%=i%>"    >
     <tr id="ligneM<%=i%>">   
     <td align="center"><input type="text" name="role2<%=i%>"   id="role2<%=i%>"  value="<%= tabMembrecommssion[i].getRole() %>" size="70" > </td>      
     <td align="center"><input type="button" id="modifierMembreCommission<%=i%>" class="btn btn-default4" value="Enregistrer" size="35"/> </td>
     <td align="center"><input type="button" id="supprimerMembreCommssion<%=i%>" class="btn btn-default4"  value="X" size="35"/> </td>         
     </tr>
     <%} %>
     </table>
     <%} %>
    
  </body>
</html>